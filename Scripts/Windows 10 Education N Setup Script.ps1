# Gustav Hagsten Larsen
# PowerShell setup script :: Windows 10 Education N

# ===================================================================
#region Function

<# Remove pinned programs.

Syntax
    Remove-TaskbarShortcut -Appname "App Navn" -Admin
#>
function Remove-TaskbarShortcut {
    param (
        $Appname
    )

    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
        Where-Object{$_.Name -eq $Appname}).Verbs() |
            Where-Object{$_.Name.replace('&','') -match 'Unpin from taskbar'} |
                ForEach-Object{$_.DoIt(); $exec = $true} 
}


<# Make new Desktop shortcut.

    Syntax
        New-DesktopShortcut -SourceExe "Path to .exe or file" -Name <Shortcut Name> -IconNumber <Number of shell32.dll icon>

    IconNumber and Admin is optional.
#>
function New-DesktopShortcut {
    param (
        [string] $SourceExe, [string] $Name, [int] $IconNumber, [switch] $Admin
    )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$HOME\Desktop\$Name.lnk")
    $Shortcut.TargetPath = $SourceExe

    # Give Shortcut custom Icon.
    if ($IconNumber) {
        $shortcut.IconLocation = "shell32.dll, $IconNumber"
    }

    $Shortcut.Save()

    # Make shortcut to open as Admin
    if ($Admin) {
        $bytes = [System.IO.File]::ReadAllBytes("$HOME\Desktop\$Name.lnk")
        # Set byte 21 (0x15) bit 6 (0x20) ON
        $bytes[0x15] = $bytes[0x15] -bor 0x20 
        [System.IO.File]::WriteAllBytes("$HOME\Desktop\$Name.lnk", $bytes)
    }
}


# Change Registry DWORD to make Taskbar less cluttered. 

function Set-MinimalTaskbar {
# Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarSmallIcons -Value 1
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowCortanaButton -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowTaskViewButton -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAnimations -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name SearchboxTaskbarMode -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds' -Name ShellFeedsTaskbarViewMode -Value 2
New-Item -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\' -Name Explorer 
New-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name DisableNotificationCenter -Value 1 -PropertyType DWord
}


# Make PowerShell Profile if it doesn't exist.

function New-Profile {
    if (Test-Path $PROFILE) {
        Write-Output "Powershell Profile exist already."
    }
    else {
        New-Item -Path $PROFILE -Type File -Force
    }
}


<# ToDo

    Set static IP or use DHCP.
    Gui Menu with checkbox list.
#>

#endregion
# ====================================================================
#region Menu

# Start script prompt.
$Start = New-Object System.Management.Automation.Host.ChoiceDescription '&Start', 'Start script with all settings.'
$GUI = New-Object System.Management.Automation.Host.ChoiceDescription '&Custom', 'Customize script to suit your own needs.'
$Exit = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'Exit process'

$options = [System.Management.Automation.Host.ChoiceDescription[]]($Start, $GUI, $Exit)

$title = 'Windows 10 Education N Setup Script'
$message = 'Do you want to start setup script now?'
$Prompt = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($Prompt) {
    0 {}
    1 { GUI }
    2 { Exit 0 }
}

#endregion
# ======================================================================
#region GUI

function GUI {

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $SetupScript                     = New-Object system.Windows.Forms.Form
    $SetupScript.ClientSize          = New-Object System.Drawing.Point(250,400)
    $SetupScript.text                = "Custom Script"
    $SetupScript.TopMost             = $false

    $Taskbar                         = New-Object system.Windows.Forms.CheckBox
    $Taskbar.text                    = "Remove pinned programs"
    $Taskbar.AutoSize                = $false
    $Taskbar.width                   = 250
    $Taskbar.height                  = 20
    $Taskbar.location                = New-Object System.Drawing.Point(30,45)
    $Taskbar.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $Taskbar.Checked                 = $true

    $Start                           = New-Object system.Windows.Forms.Button
    $Start.text                      = "Start"
    $Start.width                     = 60
    $Start.height                    = 30
    $Start.location                  = New-Object System.Drawing.Point(30,330)
    $Start.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $Start.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("")
    $Start.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#c3daa7")

    $Cancel                          = New-Object system.Windows.Forms.Button
    $Cancel.text                     = "Cancel"
    $Cancel.width                    = 60
    $Cancel.height                   = 30
    $Cancel.location                 = New-Object System.Drawing.Point(140,330)
    $Cancel.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $SetupScript.controls.AddRange(@($Taskbar,$Start,$Cancel))

    [void]$SetupScript.ShowDialog()
}

#endregion
# ======================================================================
#region Commands

# Remove default Taskbar pinned programs.
Remove-TaskbarShortcut -Appname "Microsoft Store"
Remove-TaskbarShortcut -Appname "Mail"

New-DesktopShortcut -SourceExe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Name "PowerShell Admin" -Admin
New-DesktopShortcut -SourceExe "C:\Windows\system32\notepad.exe" -Name "Notepad"
New-DesktopShortcut -SourceExe ncpa.cpl -Name "Network Connection" -IconNumber 164
New-DesktopShortcut -SourceExe sysdm.cpl -Name "System Properties" -IconNumber 272
New-DesktopShortcut -SourceExe compmgmt.msc -Name "Computer Management"

Set-MinimalTaskbar

New-Profile

# Set Danish keyboard.
Set-WinUserLanguageList -LanguageList en-DK -Force

#endregion
# ======================================================================

# End script by Restarting the Computer.
Restart-Computer