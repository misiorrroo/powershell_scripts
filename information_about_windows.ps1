# Define a function to get system information
function Get-SystemInfo {
    # Get Operating System details
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $osInfo = [PSCustomObject]@{
        OSName           = $os.Caption
        OSArchitecture   = $os.OSArchitecture
        Version          = $os.Version
        BuildNumber      = $os.BuildNumber
        ServicePack      = $os.ServicePackMajorVersion
        InstallDate      = $os.InstallDate
    }

    # Get Computer details
    $computer = Get-CimInstance -ClassName Win32_ComputerSystem
    $compInfo = [PSCustomObject]@{
        ComputerName     = $computer.Name
        Manufacturer     = $computer.Manufacturer
        Model            = $computer.Model
        TotalPhysicalMemoryGB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
        NumberOfProcessors = $computer.NumberOfProcessors
    }

    # Get Processor details
    $cpu = Get-CimInstance -ClassName Win32_Processor
    $cpuInfo = [PSCustomObject]@{
        CPUName          = $cpu.Name
        CPUCores         = $cpu.NumberOfCores
        CPULogicalProcessors = $cpu.NumberOfLogicalProcessors
        CPUClockSpeedGHz  = [math]::Round($cpu.MaxClockSpeed / 1000, 2)
    }

    # Get Disk drive details
    $disks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
    $diskInfo = $disks | ForEach-Object {
        [PSCustomObject]@{
            DriveLetter      = $_.DeviceID
            VolumeName       = $_.VolumeName
            FileSystem       = $_.FileSystem
            SizeGB           = [math]::Round($_.Size / 1GB, 2)
            FreeSpaceGB      = [math]::Round($_.FreeSpace / 1GB, 2)
        }
    }

    # Display the gathered information
    Write-Output "Operating System Information:"
    $osInfo | Format-Table -AutoSize

    Write-Output "`nComputer Information:"
    $compInfo | Format-Table -AutoSize

    Write-Output "`nProcessor Information:"
    $cpuInfo | Format-Table -AutoSize

    Write-Output "`nDisk Information:"
    $diskInfo | Format-Table -AutoSize
}

# Call the function to display system information
Get-SystemInfo
