# Gustav Hagsten Larsen

# ======================================================================
# General
# ======================================================================


# ======================================================================
# Alias
# ======================================================================

function opus { ii . }

# ======================================================================
# Scripts
# ======================================================================

# Show Hidden files in directory.
function la { (Get-ChildItem -Force) }


# Prompt Find-Filetype function
function Get-Files { 
    $file = Read-Host "Enter file type"
    Write-Host "The $((get-item $pwd).Name) directory contian $(Find-Filetype -filetype $file) of type $file" 
 }


# Open configuration files menu. (with .Net Objects)
function Get-Config {
    # Show menu with all configuration files.
    $editor = "nvim"

    $powershell = New-Object System.Management.Automation.Host.ChoiceDescription '&PowerShell', 'Path: C:\Users\Gustav\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'
    $neovim = New-Object System.Management.Automation.Host.ChoiceDescription '&NeoVim', 'Path: C:\Users\Gustav\AppData\Local\nvim\init.vim'

    $title = "Config Menu"
    $prompt = "Open Config in $editor"
    $choices = [System.Management.Automation.Host.ChoiceDescription[]] @($powershell, $neovim)
    $default = 0
     
    # Prompt for the choice
    $choice = $host.UI.PromptForChoice($Title, $Prompt, $Choices, $Default)
     
    # Action based on the choice
    switch ($choice) {
    0 { Invoke-Expression "$($editor) $($PROFILE)" }
    1 { Invoke-Expression "$($editor) C:\Users\Gustav\AppData\Local\nvim\init.vim" }
    }
}


# ======================================================================
# Functions
# ======================================================================

# Find files in dir, based on specifyed type.
function Find-Filetype {
    param (
        $filetype
    )

    $filewithtype = 0

    foreach ( $file in (Get-ChildItem -File) ) {
        if ( $file.Name.EndsWith($filetype) ) {
            $filewithtype += 1
        }
    }

    return $filewithtype
}


# ======================================================================
