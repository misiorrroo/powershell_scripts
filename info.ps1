# Get basic system information
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$computer = Get-CimInstance -ClassName Win32_ComputerSystem

# Create a custom object to hold the information
$systemInfo = [PSCustomObject]@{
    ComputerName        = $computer.Name
    OSName              = $os.Caption
    OSArchitecture      = $os.OSArchitecture
    OSVersion           = $os.Version
    TotalPhysicalMemory = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
    FreePhysicalMemory  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
}

# Display the information
$systemInfo | Format-Table -AutoSize
