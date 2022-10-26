# Gustav Hagsten Larsen
# PowerShell setup script :: Windows 10 Education N

# ===================================================================
# Functions
# ===================================================================

<#

Remove pinned programs.

Syntax
    Remove-TaskbarShortcut [-Appname] <string[]>

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


<#

Make new Desktop shortcut.

Syntax
    New-DesktopShortcut [-SourceExe] <string[]> [-Name] <string[]> [-IconNumber] 164

#>

function New-DesktopShortcut {
    param (
        [string]$SourceExe, [string]$Name, $IconNumber, [switch] $Admin
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


# Set static IP or use DHCP

function Set-NetworkConfig {

}


<# Unpin Startmenu pin      !! Not working because permission denied by WMI

(New-Object -Com Shell.Application).
    NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
    Items() |
    ForEach-Object{ $_.Verbs() } |
    Where-Object{$_.Name -match 'Un.*pin from Start'} |
    ForEach-Object{$_.DoIt()}
#>


# ====================================================================

# Remove default Taskbar pinned programs.
Remove-TaskbarShortcut -appname "Microsoft Store"
Remove-TaskbarShortcut -appname "Mail"

New-DesktopShortcut -SourceExe ncpa.cpl -Name "Network Connection" -IconNumber 164
New-DesktopShortcut -SourceExe sysdm.cpl -Name "System Properties" -IconNumber 272
New-DesktopShortcut -SourceExe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Name "PowerShell Admin" -Admin

Set-MinimalTaskbar

New-Profile

# Set Danish keyboard.
Set-WinUserLanguageList -LanguageList en-DK -Force

# End script by Restarting the Computer.
Restart-Computer