# Gustav Hagsten Larsen
# PowerShell setup script :: Windows 10 Education N

<# ToDo

    Set static IP or use DHCP.
#>

<# Bugs

    Custom shortcut icons not working.
#>

# ======================================================================

# Import Logic.ps1
. $PSScriptRoot/Logic.ps1



function TaskbarShortcut {
Remove-TaskbarShortcut -Appname "Microsoft Store"
Remove-TaskbarShortcut -Appname "Mail"
}

function DesktopShortcut {
New-DesktopShortcut -SourceExe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Name "PowerShell Admin" -Admin
New-DesktopShortcut -SourceExe "C:\Windows\system32\notepad.exe" -Name "Notepad"
New-DesktopShortcut -SourceExe ncpa.cpl -Name "Network Connection" -IconNumber 164
New-DesktopShortcut -SourceExe sysdm.cpl -Name "System Properties" -IconNumber 272
New-DesktopShortcut -SourceExe compmgmt.msc -Name "Computer Management"
}

function MinimalTaskbar {
Set-MinimalTaskbar
}

function PowerShell {
New-Profile
}

function Keyboard {
Set-WinUserLanguageList -LanguageList en-DK -Force
}



# Starting the Script

function StartScript {
    if ($MinimalTaskbar.Checked -eq $true)  { MinimalTaskbar }
    if ($TaskbarShortcut.Checked -eq $true) { TaskbarShortcut }
    if ($DesktopShortcut.Checked -eq $true) { DesktopShortcut }
    if ($PowerShell.Checked -eq $true)      { PowerShell }
    if ($Keyboard.Checked -eq $true)        { Keyboard }
    Restart-Computer
}


function Cancel {
    $SetupScript.Close()
}


# Import Script GUI
. $PSScriptRoot/Form.ps1