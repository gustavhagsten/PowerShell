# Import Logic
. $PSScriptRoot\Logic.ps1

# Select Domain Controller


# Add User 


# Select OU and SG



# Load GUI
. $PSScriptRoot\Form.ps1

# List all organizationalUnits
$OU = Get-ADOrganizationalUnit -Filter 'Name -like "*"'

foreach ($item in $OU) {
    [void] $OUList.Items.Add($item.Name)
}

# List all SG
$SG = Get-ADGroup -Filter 'Name -like "*"'

foreach ($item in $SG) {
    [void] $SGList.Items.Add($item.Name)
}


# Start GUI
[void]$SetupScript.ShowDialog()