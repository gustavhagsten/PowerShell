# Get duration of all mp4 files in folder.


$Folder = $PSScriptRoot

foreach ($Item in $Folder) {
    $LengthColumn = 27
    $File = $Item
    $objShell = New-Object -ComObject Shell.Application 
    $objFolder = $objShell.Namespace($Folder)
    $objFile = $objFolder.ParseName($File)
    $Length = $objFolder.GetDetailsOf($objFile, $LengthColumn)

    Write-Output $Length
}
