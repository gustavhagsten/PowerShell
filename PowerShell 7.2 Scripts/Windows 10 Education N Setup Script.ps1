# Gustav Hagsten Larsen
# PowerShell setup script :: Windows 10 Education N


# Functions
# Remove pinned programs.
function UnpinTaskbar {
    param (
        $appname
    )

    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
        Where-Object{$_.Name -eq $appname}).Verbs() |
            Where-Object{$_.Name.replace('&','') -match 'Unpin from taskbar'} |
                ForEach-Object{$_.DoIt(); $exec = $true} 
}


# Remove default Taskbar pin.
UnpinTaskbar -appname "Microsoft Store"
UnpinTaskbar -appname "Mail"


<# !! Not working because permission denied by WMI

# Unpin Startmenu pin.
(New-Object -Com Shell.Application).
    NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
    Items() |
    ForEach-Object{ $_.Verbs() } |
    Where-Object{$_.Name -match 'Un.*pin from Start'} |
    ForEach-Object{$_.DoIt()}
#>


# Edit Taskbar.
# Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarSmallIcons -Value 1
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowCortanaButton -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowTaskViewButton -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAnimations -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name SearchboxTaskbarMode -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds' -Name ShellFeedsTaskbarViewMode -Value 2
New-Item -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\' -Name Explorer 
New-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name DisableNotificationCenter -Value 1 -PropertyType DWord


# Set Danish keyboard.
Set-WinUserLanguageList -LanguageList en-DK -Force


Restart-Computer