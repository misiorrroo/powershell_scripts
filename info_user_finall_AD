param(   [string]$UserName
)

if (-not $UserName) {
    Write-Host "Podaj nazwę użytkownika jako parametr!" -ForegroundColor Red
    exit
}

# Pobranie informacji o użytkowniku
$user = Get-ADUser -Identity $UserName -Properties *

if ($user) {
    Write-Host "Informacje o użytkowniku: $UserName" -ForegroundColor Green
    $user | Select-Object SamAccountName, Name, GivenName, Surname, UserPrincipalName, EmailAddress, Title, Department, 
                            Office, Enabled, LockedOut, LastLogonDate, PasswordLastSet, PasswordNeverExpires, 
                            DistinguishedName | Format-List
} else {
    Write-Host "Nie znaleziono użytkownika: $UserName" -ForegroundColor Red


#Uruchom skrypt w PowerShellu na kontrolerze domeny, podając nazwę użytkownika jako parametr: .\Get-UserInfo.ps1 -UserName "jan.kowalski"
