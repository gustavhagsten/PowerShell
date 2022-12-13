# Make input boxes, with all the diffrent user credentials.
function New-ADDSUser {
    #Username is a made with $Firstname plus $Lastname
    param ($Firstname, $Lastname, $LoginName, $Password)

    $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

    New-ADUser -Name "$Firstname $Lastname" -GivenName $Firstname -Surname $Lastname -SamAccountName $LoginName -Path "OU=$OU,DC=DomainTest,DC=local" -AccountPassword $SecurePassword -Enabled $true
}


# Select OU and SG if it exits


function New-User {

    # Check if passwords match
    if ($PasswordBox.Text -ne $ConfirmPasswordBox.Text) {
#        Write-Host "Passwords need to match!"
        [System.Windows.MessageBox]::Show("Passwords need to match!")
        return 
    }

    # Check Organizational Unit
    if ($OUList.Text -eq "Organizational Units") {
        Write-Host "You Need to select a Organizational Units"
        return
    }
    else {
        $OU = $OUList.Text
    }


    # Create User on Domain
    New-ADDSUser -Firstname $FirstnameBox.Text -Lastname $LastnameBox.Text -LoginName $LoginBox.Text -Password $ConfirmPasswordBox.Text

    Write-Host $LoginBox.Text "is created."

}

function Test-Function{
    Write-Host     
}