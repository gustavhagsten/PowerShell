# Gustav Hagsten Larsen

# ======================================================================
# General
# ======================================================================


# ======================================================================
# Alias
# ======================================================================

# Show configuration file menu.
Set-Alias conf configFileMenu

Set-Alias findfile FindFilePrompt


# ======================================================================
# Scripts
# ======================================================================

# Show Hidden files in directory.
function la { (Get-ChildItem -Force).Name }


# Prompt Find-Filetype function
function Get-Files { 
    $file = Read-Host "Enter file type"
    Write-Host "The $((get-item $pwd).Name) directory contian $(Find-Filetype -filetype $file) of type $file" 
 }


# Open configuration files menu. (with .Net Objects)
function Get-Config {
    # Show menu with all configuration files.
    $editor = "code"

    $powershell = New-Object System.Management.Automation.Host.ChoiceDescription '&PowerShell', 'Path: C:\Users\Gustav\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'
    
    $title = "Config Menu"
    $prompt = "Open Config in $editor"
    $choices = [System.Management.Automation.Host.ChoiceDescription[]] @($powershell)
    $default = 0
     
    # Prompt for the choice
    $choice = $host.UI.PromptForChoice($Title, $Prompt, $Choices, $Default)
     
    # Action based on the choice
    switch ($choice) {
    0 { Invoke-Expression "$($editor) $($PROFILE)" }
    }
}


# ======================================================================
# Functions
# ======================================================================

# Find files in dir, based on specifyed type.
function Find-Filetype {
    param ( $filetype )

    $filewithtype = 0

    foreach ( $file in (Get-ChildItem -File) ) {
        if ( $file.Name.EndsWith($filetype) ) {
            $filewithtype += 1
        }
    }

    return $filewithtype
}


# ======================================================================