# Defining a function to calculate the folder size
function Get-FolderSize {
    param (
        [string]$FolderPath
    )
    
    # Using Get-ChildItem to Collect All Files in a Folder and Subfolders
    $folderSize = (Get-ChildItem -Path $FolderPath -Recurse -ErrorAction SilentlyContinue | 
                   Measure-Object -Property Length -Sum).Sum
    
    # Size of folders
    $sizeInMB = [math]::round($folderSize / 1MB, 2)
    
    return $sizeInMB
}

# Patch to C:\
$rootPath = "C:\"

$folders = Get-ChildItem -Path $rootPath -Directory

foreach ($folder in $folders) {
    $size = Get-FolderSize -FolderPath $folder.FullName
    Write-Output ("Folder: {0} - Rozmiar: {1} MB" -f $folder.Name, $size)
}
