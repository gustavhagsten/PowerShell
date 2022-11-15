$DC = Get-ADDomainController


<# Make input boxes, with all the diffrent user credentials.
- Make a TextBox.
- Make a CheckBox.
- Make a CreateUser button, that check the inputs fields.

#>
function CreateADDSUser{
    param ( $Username, $GivenName, $Surname, $LoginName )

    New-ADUser -Name $Username -GivenName $GivenName -Surname $Surname -SamAccountName $LoginName -Path "OU=DomainUsers,DC=DomainTest,DC=local" -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $true
}

<# Select OU and SG if it exits

#>