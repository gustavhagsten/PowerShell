Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$SetupScript                     = New-Object system.Windows.Forms.Form
$SetupScript.ClientSize          = New-Object System.Drawing.Point(375,370)
$SetupScript.text                = "Create User"
$SetupScript.TopMost             = $false
$SetupScript.FormBorderStyle     = "FixedDialog"

$Domainname                      = New-Object system.Windows.Forms.Label
$Domainname.text                 = $DC.Domain
$Domainname.AutoSize             = $true
$Domainname.width                = 25
$Domainname.height               = 10
$Domainname.location             = New-Object System.Drawing.Point(15,20)
$Domainname.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$UsernameBox                     = New-Object system.Windows.Forms.TextBox
$UsernameBox.multiline           = $false
$UsernameBox.width               = 100
$UsernameBox.height              = 20
$UsernameBox.location            = New-Object System.Drawing.Point(100,70)
$UsernameBox.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$UsernameText                    = New-Object system.Windows.Forms.Label
$UsernameText.text               = "Username"
$UsernameText.AutoSize           = $true
$UsernameText.width              = 25
$UsernameText.height             = 10
$UsernameText.location           = New-Object System.Drawing.Point(15,70)
$UsernameText.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LoginBox                        = New-Object system.Windows.Forms.TextBox
$LoginBox.multiline              = $false
$LoginBox.width                  = 100
$LoginBox.height                 = 20
$LoginBox.location               = New-Object System.Drawing.Point(260,120)
$LoginBox.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LoginText                       = New-Object system.Windows.Forms.Label
$LoginText.text                  = "Login"
$LoginText.AutoSize              = $true
$LoginText.width                 = 25
$LoginText.height                = 10
$LoginText.location              = New-Object System.Drawing.Point(210,120)
$LoginText.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$GivenNameBox                    = New-Object system.Windows.Forms.TextBox
$GivenNameBox.multiline          = $false
$GivenNameBox.width              = 100
$GivenNameBox.height             = 20
$GivenNameBox.location           = New-Object System.Drawing.Point(100,120)
$GivenNameBox.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$GivenNameText                   = New-Object system.Windows.Forms.Label
$GivenNameText.text              = "GivenName"
$GivenNameText.AutoSize          = $true
$GivenNameText.width             = 25
$GivenNameText.height            = 10
$GivenNameText.location          = New-Object System.Drawing.Point(15,120)
$GivenNameText.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SurnameBox                      = New-Object system.Windows.Forms.TextBox
$SurnameBox.multiline            = $false
$SurnameBox.width                = 260
$SurnameBox.height               = 20
$SurnameBox.location             = New-Object System.Drawing.Point(100,150)
$SurnameBox.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SurnameText                     = New-Object system.Windows.Forms.Label
$SurnameText.text                = "Surname"
$SurnameText.AutoSize            = $true
$SurnameText.width               = 25
$SurnameText.height              = 10
$SurnameText.location            = New-Object System.Drawing.Point(15,150)
$SurnameText.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SetupScript.controls.AddRange(@($Domainname, $UsernameBox, $UsernameText, $LoginBox, $LoginText, $GivenNameBox, $GivenNameText, $SurnameBox, $SurnameText))