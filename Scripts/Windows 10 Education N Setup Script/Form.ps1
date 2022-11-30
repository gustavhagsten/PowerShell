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