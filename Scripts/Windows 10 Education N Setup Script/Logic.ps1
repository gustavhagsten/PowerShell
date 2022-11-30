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


# Check if PowerShell PROFILE exist and make one.

function New-Profile {
    if (Test-Path $PROFILE) {
        Write-Output "Powershell Profile exist already."
    }
    else {
        New-Item -Path $PROFILE -Type File -Force
    }
}
