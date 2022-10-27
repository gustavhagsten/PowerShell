$Yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', 'Start Script'
$No = New-Object System.Management.Automation.Host.ChoiceDescription '&No', 'Exit process'

$options = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No)

$title = 'Windows 10 Education N Setup Script'
$message = 'Do you want to start setup script now?'
$Start = $host.ui.PromptForChoice($title, $message, $options, 1)

Write-Host $Start