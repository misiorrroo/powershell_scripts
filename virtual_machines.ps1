# Check if VMware PowerCLI is installed
if (Get-Module -ListAvailable -Name VMware.PowerCLI) {
    # Import the VMware PowerCLI module
    Import-Module VMware.PowerCLI

    # Connect to the VMware vCenter server
    $vCenterServer = "your-vcenter-server"  # Replace with your vCenter server name
    Connect-VIServer -Server $vCenterServer

    # Get VM information
    $vms = Get-VM
    if ($vms) {
        Write-Output "Virtual Machines Information:"
        $vms | Select-Object Name, PowerState, NumCPU, MemoryMB, ProvisionedSpaceGB, UsedSpaceGB | Format-Table -AutoSize
    } else {
        Write-Output "No virtual machines found."
    }

    # Disconnect from the VMware vCenter server
    Disconnect-VIServer -Server $vCenterServer -Confirm:$false
} else {
    Write-Output "VMware PowerCLI module is not installed."
}
