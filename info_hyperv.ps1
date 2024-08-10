# Check if the Hyper-V module is available
if (Get-Module -ListAvailable -Name Hyper-V) {
    # Import the Hyper-V module
    Import-Module Hyper-V

    # Get VM information
    $vms = Get-VM
    if ($vms) {
        Write-Output "Virtual Machines Information:"
        $vms | Select-Object Name, State, CPUUsage, MemoryAssigned, Uptime, Status | Format-Table -AutoSize
    } else {
        Write-Output "No virtual machines found."
    }
} else {
    Write-Output "Hyper-V module is not installed."
}
