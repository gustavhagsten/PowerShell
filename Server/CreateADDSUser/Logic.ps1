function FunctionName {
    param ( $Username, $GivenName, $Surname, $LoginName )

    New-ADUser -Name $Username -GivenName $GivenName -Surname $Surname -SamAccountName $LoginName -Path "OU=DomainUsers,DC=DomainTest,DC=local" -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $true
    
}