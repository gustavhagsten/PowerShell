# Gustav Hagsten Larsen
# PowerShell setup script :: Windows 10 Education N

<# ToDo

    Set static IP or use DHCP.
#>

<# Bugs

    Custom shortcut icons not working.
#>

# ======================================================================
#region Logic

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
        New-DesktopShortcut -SourceExe "Path to .exe or file" -Name <TaskbarShortcut Name> -IconNumber <Number of shell32.dll icon>

    IconNumber and Admin is optional.
#>
function New-DesktopShortcut {
    param (
        [string] $SourceExe, [string] $Name, $IconNumber, [switch] $Admin
    )

    $WshShell = New-Object -comObject WScript.Shell
    $TaskbarShortcut = $WshShell.CreateShortcut("$HOME\Desktop\$Name.lnk")
    $TaskbarShortcut.TargetPath = $SourceExe

    # Give TaskbarShortcut custom Icon.
    if ($IconNumber) {
        $shortcut.IconLocation = "shell32.dll,$IconNumber"
    }

    $TaskbarShortcut.Save()

    # Make shortcut to open as Admin
    if ($Admin) {
        $bytes = [System.IO.File]::ReadAllBytes("$HOME\Desktop\$Name.lnk")
        # Set byte 21 (0x15) bit 6 (0x20) ON
        $bytes[0x15] = $bytes[0x15] -bor 0x20 
        [System.IO.File]::WriteAllBytes("$HOME\Desktop\$Name.lnk", $bytes)
    }
}


# Change Registry DWORD to make MinimalTaskbar less cluttered. 

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

#endregion
# ======================================================================
#region Commands

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

function StartAll {
    # if you start the script without custom option, run all options.
    MinimalTaskbar
    TaskbarShortcut
    DesktopShortcut
    PowerShell
    Keyboard

    # End script by Restarting the Computer.
    Restart-Computer
}

#endregion
# ======================================================================
#region GUI

function GUI {

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $SetupScript                = New-Object system.Windows.Forms.Form
    $SetupScript.ClientSize     = New-Object System.Drawing.Point(250,400)
    $SetupScript.text           = "Custom Script"
    $SetupScript.TopMost        = $false

    $MinimalTaskbar             = New-Object system.Windows.Forms.CheckBox
    $MinimalTaskbar.text        = "Less cluttered Taskbar."
    $MinimalTaskbar.AutoSize    = $false
    $MinimalTaskbar.width       = 250
    $MinimalTaskbar.height      = 20
    $MinimalTaskbar.location    = New-Object System.Drawing.Point(30,45)
    $MinimalTaskbar.Font        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $MinimalTaskbar.Checked     = $true

    $TaskbarShortcut            = New-Object system.Windows.Forms.CheckBox
    $TaskbarShortcut.text       = "Remove pinned programs."
    $TaskbarShortcut.AutoSize   = $false
    $TaskbarShortcut.width      = 250
    $TaskbarShortcut.height     = 20
    $TaskbarShortcut.location   = New-Object System.Drawing.Point(30,70)
    $TaskbarShortcut.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $TaskbarShortcut.Checked    = $true

    $DesktopShortcut            = New-Object system.Windows.Forms.CheckBox
    $DesktopShortcut.text       = "Make new Desktop shortcut."
    $DesktopShortcut.AutoSize   = $false
    $DesktopShortcut.width      = 250
    $DesktopShortcut.height     = 20
    $DesktopShortcut.location   = New-Object System.Drawing.Point(30,95)
    $DesktopShortcut.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $DesktopShortcut.Checked    = $true

    $PowerShell                 = New-Object system.Windows.Forms.CheckBox
    $PowerShell.text            = "Make PowerShell Profile."
    $PowerShell.AutoSize        = $false
    $PowerShell.width           = 250
    $PowerShell.height          = 20
    $PowerShell.location        = New-Object System.Drawing.Point(30,120)
    $PowerShell.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $PowerShell.Checked         = $true

    $Keyboard                   = New-Object system.Windows.Forms.CheckBox
    $Keyboard.text              = "Set DK Keyboard"
    $Keyboard.AutoSize          = $false
    $Keyboard.width             = 250
    $Keyboard.height            = 20
    $Keyboard.location          = New-Object System.Drawing.Point(30,145)
    $Keyboard.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $Keyboard.Checked           = $true

    $Start                      = New-Object system.Windows.Forms.Button
    $Start.text                 = "Start"
    $Start.width                = 60
    $Start.height               = 30
    $Start.location             = New-Object System.Drawing.Point(30,330)
    $Start.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $Start.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("")
    $Start.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#c3daa7")

    $Cancel                     = New-Object system.Windows.Forms.Button
    $Cancel.text                = "Cancel"
    $Cancel.width               = 60
    $Cancel.height              = 30
    $Cancel.location            = New-Object System.Drawing.Point(140,330)
    $Cancel.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $Start.Add_Click({ StartScript })
    $Cancel.Add_Click({ Cancel })

    $SetupScript.controls.AddRange(@($MinimalTaskbar, $TaskbarShortcut, $DesktopShortcut, $PowerShell, $Keyboard, $Start, $Cancel))

    [void]$SetupScript.ShowDialog()
}

#endregion
# ======================================================================
GUI # Start in GUI mode

<# Menu

# Start script prompt.
$Start = New-Object System.Management.Automation.Host.ChoiceDescription '&Start', 'Start script with all settings.'
$GUI = New-Object System.Management.Automation.Host.ChoiceDescription '&Custom', 'Customize script to suit your needs.'
$Exit = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'Exit process'

$options = [System.Management.Automation.Host.ChoiceDescription[]]($Start, $GUI, $Exit)

$title = 'Windows 10 Education N Setup Script'
$message = 'Do you want to start setup script now?'
$Prompt = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($Prompt) {
    0 { StartAll }
    1 { GUI }
    2 { Exit 0 }
}

#>
# ======================================================================