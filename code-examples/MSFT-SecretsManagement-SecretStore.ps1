#### More Info on Secrets Management found here: https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/

# Install the modules
Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore

# Create a local SecretStore (one day we would instead register a bitwarden ext SV instead)
Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault 


# Create a test secret
    # Note: if this is the first one in the vault it will ask for a password
    # Note: Setting the Secret does not seem to write it to the history of the machine in a test file, find that file here: 
        # Get-PSReadlineOption | SELECT-OBJECT -ExpandProperty HistorySavePath
Set-Secret -Name TestSecret -Secret "TestSecret"

# Kill Password Requirement (optional) but must be done AFTER you create your first secret
Set-SecretStoreConfiguration -Authentication None

# Get Secret
Get-Secret -Name TestSecret -AsPlainText

# List all Secrets: 
Get-Secretinfo

##################
# Deeper Dive
##################

### Where are the SecretStore SecretVault objects stored on the file system?
    # For Windows platforms the location is: $env:LOCALAPPDATA\Microsoft\PowerShell\secretmanagement\localstore\
    # For Non-Windows platforms the location is: $HOME/.secretmanagement/localstore/
    # The file storeaux, storeconfig, storefile only change when you set a secret (which is when a password is set on the vault)

### Scope: Scope can be set to CurrentUser or AllUsers using set-secretstoreconfiguration


