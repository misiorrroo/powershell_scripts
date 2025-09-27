$servers = @('Srv01','Srv02') #dane maszyny
$cpuThreshold = 80   # procent użycia CPU
$memThresholdGB = 2  # np proces używa >2 GB pamięci
$outFile = "C:\Temp\HighUsageProcesses.csv"

# nagłówek
"Server,ProcessName,PID,CPU,MemoryGB,Time" | Out-File $outFile

$sbScan = {
    param($srv, $cpuThresh, $memThreshGB)
    $procs = Invoke-Command -ComputerName $srv -ScriptBlock {
        Get-Process | Select-Object Name, Id, CPU, @{ Name="MemoryGB"; Expression={ $_.WorkingSet /1GB }}, Responding
    } -ErrorAction SilentlyContinue

    foreach ($p in $procs) {
        if ($null -ne $p) {
            if ($p.CPU -gt $cpuThresh -or $p.MemoryGB -gt $memThreshGB) {
                # zapisz linie do pliku
                $line = "{0},{1},{2},{3:F2},{4:F2},{5}" -f $srv, $p.Name, $p.Id, $p.CPU, $p.MemoryGB, (Get-Date) #oczywiście format dowolny, sporo sie z tym bawiłem, tak wygląda ok :)
                $line
            }
        }
    }
}

foreach ($srv in $servers) {
    & $sbScan $srv $cpuThreshold $memThresholdGB | Out-File $outFile -Append
}

#Celem jest zbieranie procesów przekraczających użycie CPU lub pamięci i raportowanie
