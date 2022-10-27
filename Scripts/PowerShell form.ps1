<# 
.NAME
    Winform Test
#>

#region Logic 

function ExitButton {
    $Form.Close()
}

function StartButton {
    if ($checkbox1.Checked -eq $true) { Write-Host "Hello world!" }
    if ($checkbox2.Checked -eq $true) { Write-Host "Hello world!2" }

}

#endregion


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.text                       = "Customize Setup"
$Form.TopMost                    = $false

$Start                           = New-Object system.Windows.Forms.Button
$Start.text                      = "Start"
$Start.width                     = 60
$Start.height                    = 30
$Start.location                  = New-Object System.Drawing.Point(38,329)
$Start.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Start.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$Exit                            = New-Object system.Windows.Forms.Button
$Exit.text                       = "Exit"
$Exit.width                      = 60
$Exit.height                     = 30
$Exit.visible                    = $true
$Exit.location                   = New-Object System.Drawing.Point(126,329)
$Exit.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Exit.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Exit.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

# Create checkbox 
$checkbox1                       = New-Object System.Windows.Forms.checkbox
$checkbox1.Text                  = "Enable/Disable OK button"
$checkbox1.Location              = New-Object System.Drawing.Size(30,30)
$checkbox1.Size                  = New-Object System.Drawing.Size(250,50)
$checkbox1.Checked               = $false
$Form.Controls.Add($checkbox1)  

$checkbox2                       = New-Object System.Windows.Forms.checkbox
$checkbox2.Text                  = "check 2"
$checkbox2.Location              = New-Object System.Drawing.Size(30,65)
$checkbox2.Size                  = New-Object System.Drawing.Size(250,50)
$checkbox2.Checked               = $false
$Form.Controls.Add($checkbox2)  


$Exit.Add_Click({ExitButton})
$Start.Add_Click({StartButton})

$Form.controls.AddRange(@($Start,$Exit,$checkbox1,$checkbox2))


# End
[void]$Form.ShowDialog()

