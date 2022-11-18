Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$SetupScript                     = New-Object system.Windows.Forms.Form
$SetupScript.ClientSize          = New-Object System.Drawing.Point(380,390)
$SetupScript.text                = "Create User"
$SetupScript.TopMost             = $false
$SetupScript.FormBorderStyle     = "FixedDialog"

$Domainname                      = New-Object system.Windows.Forms.Label
$Domainname.text                 = (Get-ADDomainController).Domain
$Domainname.AutoSize             = $true
$Domainname.width                = 25
$Domainname.height               = 10
$Domainname.location             = New-Object System.Drawing.Point(15,20)
$Domainname.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',15)

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

$PasswordBox                     = New-Object system.Windows.Forms.TextBox
$PasswordBox.multiline           = $false
$PasswordBox.width               = 210
$PasswordBox.height              = 20
$PasswordBox.location            = New-Object System.Drawing.Point(150,130)
$PasswordBox.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$PasswordText                    = New-Object system.Windows.Forms.Label
$PasswordText.text               = "Password:"
$PasswordText.AutoSize           = $true
$PasswordText.width              = 25
$PasswordText.height             = 10
$PasswordText.location           = New-Object System.Drawing.Point(15,130)
$PasswordText.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ConfirmPasswordBox              = New-Object system.Windows.Forms.TextBox
$ConfirmPasswordBox.multiline    = $false
$ConfirmPasswordBox.width        = 210
$ConfirmPasswordBox.height       = 20
$ConfirmPasswordBox.location     = New-Object System.Drawing.Point(150,160)
$ConfirmPasswordBox.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ConfirmPasswordText             = New-Object system.Windows.Forms.Label
$ConfirmPasswordText.text        = "Confirm Password:"
$ConfirmPasswordText.AutoSize    = $true
$ConfirmPasswordText.width       = 25
$ConfirmPasswordText.height      = 10
$ConfirmPasswordText.location    = New-Object System.Drawing.Point(15,160)
$ConfirmPasswordText.Font        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$OUList                       = New-Object system.Windows.Forms.ComboBox
$OUList.text                  = "Organizational Units"
$OUList.width                 = 160
$OUList.height                = 20
$OUList.location              = New-Object System.Drawing.Point(15,200)
$OUList.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SGList                       = New-Object system.Windows.Forms.ComboBox
$SGList.text                  = "Security Groups"
$SGList.width                 = 160
$SGList.height                = 20
$SGList.location              = New-Object System.Drawing.Point(200,200)
$SGList.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SetupScript.controls.AddRange(@($Domainname, $LoginBox, $LoginText, $FirstnameBox, $FirstnameText, $LastnameBox, $LastnameText, $PasswordText, $PasswordBox, $ConfirmPasswordText, $ConfirmPasswordBox, $OUList, $SGList))