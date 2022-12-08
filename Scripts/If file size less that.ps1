foreach ($image in Get-ChildItem) {
    if ($image.Length -lt 240000) {
        Remove-Item $image
    }
}