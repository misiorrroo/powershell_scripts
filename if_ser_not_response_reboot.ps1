# serwery, na których monitorujemy
$servers = @('Srv01','Srv02','Srv03')
# nazwa procesu (exe)
$procName = 'MyServiceWorker'
#parametr dużej pętli ehile true, ktora powtarza się co zadeklarowany czas np co godzinę
$time_interval_min = 60

# ScriptBlock który sprawdza proces i restartuje, jeśli nie odpowiada
$sbCheckRestart = {
    param($srv, $pName)

    try {
        $procs = Get-Process -ComputerName $srv -Name $pName -ErrorAction Stop
    } catch {
        Write-Host "$srv: proces $pName nie działa (nie znaleziono)" -ForegroundColor Yellow
        # opcjonalnie: uruchom
        Start-Process -FilePath "C:\Program Files\MyApp\$pName.exe" -ArgumentList '' -ComputerName $srv
        Write-Host "$srv: uruchamianie procesu $pName" -ForegroundColor Green
        return
    }

    foreach ($p in $procs) {
        if (-not $p.Responding) {
            Write-Host "$srv: proces PID $($p.Id) nie odpowiada, restartuję" -ForegroundColor Red
            Stop-Process -ComputerName $srv -Id $p.Id -Force
            # krótkie oczekiwanie
            Start-Sleep -Seconds 5
            Start-Process -FilePath $p.Path -ComputerName $srv
            Write-Host "$srv: proces $pName został ponownie uruchomiony" -ForegroundColor Green
        } else {
            Write-Host "$srv: proces PID $($p.Id) działa poprawnie"
        }
    }
}

# cykliczna pętla
while ($true) {
    foreach ($srv in $servers) {
        & $sbCheckRestart $srv $procName
    }
    Start-Sleep -Seconds ($time_interval_min * 60) #<----
}

#Celem powyżeszgo skryptu jest monitorowanie procesów i restart, jeśli są zawieszone, bardzo fajne i praktyczne!
