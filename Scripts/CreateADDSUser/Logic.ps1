# Make input boxes, with all the diffrent user credentials.
function CreateADDSUser {
    #Username is a made with $Firstname plus $Lastname
    param ( $Username, $Firstname, $Lastname, $LoginName, $Password)

    New-ADUser -Name $Username -GivenName $Firstname -Surname $Lastname -SamAccountName $LoginName -Path "OU=Sale,DC=DomainTest,DC=local" -AccountPassword $Password -Enabled $true
}

function CreateUser {
    if ($PasswordBox.Text -eq $ConfirmPasswordBox.Text) {
        
    }
}

# Select OU and SG if it exits