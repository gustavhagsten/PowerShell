# Import Logic
. $PSScriptRoot\Logic.ps1



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
    if ($item.Name.Startswith("SG")) {
        [void] $SGList.Items.Add($item.Name)
    }
}

$CreateUserButton.Add_Click({ New-User })
#$CreateUserButton.Add_Click({ Test-Function })

# Start GUI
[void]$SetupScript.ShowDialog()
