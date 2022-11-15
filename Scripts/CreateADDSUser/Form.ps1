Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$SetupScript                     = New-Object system.Windows.Forms.Form
$SetupScript.ClientSize          = New-Object System.Drawing.Point(380,390)
$SetupScript.text                = "Create User"
$SetupScript.TopMost             = $false
$SetupScript.FormBorderStyle     = "FixedDialog"

$Domainname                      = New-Object system.Windows.Forms.Label
$Domainname.text                 = $DC.Domain
$Domainname.AutoSize             = $true
$Domainname.width                = 25
$Domainname.height               = 10
$Domainname.location             = New-Object System.Drawing.Point(15,25)
$Domainname.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$LoginBox                        = New-Object system.Windows.Forms.TextBox
$LoginBox.multiline              = $false
$LoginBox.width                  = 100
$LoginBox.height                 = 20
$LoginBox.location               = New-Object System.Drawing.Point(260,70)
$LoginBox.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LoginText                       = New-Object system.Windows.Forms.Label
$LoginText.text                  = "Login:"
$LoginText.AutoSize              = $true
$LoginText.width                 = 25
$LoginText.height                = 10
$LoginText.location              = New-Object System.Drawing.Point(210,70)
$LoginText.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$FirstnameBox                    = New-Object system.Windows.Forms.TextBox
$FirstnameBox.multiline          = $false
$FirstnameBox.width              = 100
$FirstnameBox.height             = 20
$FirstnameBox.location           = New-Object System.Drawing.Point(100,70)
$FirstnameBox.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$FirstnameText                   = New-Object system.Windows.Forms.Label
$FirstnameText.text              = "First name:"
$FirstnameText.AutoSize          = $true
$FirstnameText.width             = 25
$FirstnameText.height            = 10
$FirstnameText.location          = New-Object System.Drawing.Point(15,70)
$FirstnameText.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LastnameBox                     = New-Object system.Windows.Forms.TextBox
$LastnameBox.multiline           = $false
$LastnameBox.width               = 260
$LastnameBox.height              = 20
$LastnameBox.location            = New-Object System.Drawing.Point(100,100)
$LastnameBox.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LastnameText                    = New-Object system.Windows.Forms.Label
$LastnameText.text               = "Last name:"
$LastnameText.AutoSize           = $true
$LastnameText.width              = 25
$LastnameText.height             = 10
$LastnameText.location           = New-Object System.Drawing.Point(15,100)
$LastnameText.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SetupScript.controls.AddRange(@($Domainname, $LoginBox, $LoginText, $FirstnameBox, $FirstnameText, $LastnameBox, $LastnameText))