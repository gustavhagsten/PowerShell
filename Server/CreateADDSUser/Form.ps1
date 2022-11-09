Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$SetupScript                 = New-Object system.Windows.Forms.Form
$SetupScript.ClientSize      = New-Object System.Drawing.Point(250,400)
$SetupScript.text            = "Create User"
$SetupScript.TopMost         = $false
$SetupScript.FormBorderStyle = "FixedDialog"

$Domain                      = New-Object system.Windows.Forms.ComboBox
$Domain.text                 = "Select Domain Controller"
$Domain.width                = 195
$Domain.height               = 20
$Domain.location             = New-Object System.Drawing.Point(25,25)
$Domain.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$UsernameBox                 = New-Object system.Windows.Forms.TextBox
$UsernameBox.multiline       = $false
$UsernameBox.width           = 100
$UsernameBox.height          = 20
$UsernameBox.location        = New-Object System.Drawing.Point(120,60)
$UsernameBox.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$UsernameText                = New-Object system.Windows.Forms.Label
$UsernameText.text           = "Username"
$UsernameText.AutoSize       = $true
$UsernameText.width          = 25
$UsernameText.height         = 10
$UsernameText.location       = New-Object System.Drawing.Point(25,60)
$UsernameText.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

[void] $Domain.Items.Add("Item 1")
[void] $Domain.Items.Add("Item 2")
[void] $Domain.Items.Add("Item 3")

$SetupScript.controls.AddRange(@($Domain, $UsernameBox, $UsernameText))

[void]$SetupScript.ShowDialog()