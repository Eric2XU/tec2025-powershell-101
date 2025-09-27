# This script gives guidance for setting up listView in PSReadline
# It is not intended to be run as a script
# It is just a set of commands to run in the terminal depending on your environment
# Don't forget this is per instance of PowerShell, so you do have to do this twice, once for PowerShell for Windows (PowerShell.exe) and once for PowerShell Core (pwsh.exe)

# -------------------------------
# PreRequisites: You must have PSReadline 2.1 or higher installed
# -------------------------------

# Check if you have a new enough version of PSReadline
Get-Module -Name PSReadLine
# If you do not have version 2.1 or higher, install it
# Install the module (use -force as 2.0 will already be installed)
Install-Module -Name PSReadLine -AllowClobber -Force
# Don't forget to restart your terminal after installing the module

# -------------------------------
# Verification: Check if it will work manually 
# -------------------------------
Set-PSReadLineOption -PredictionViewStyle ListView 
# No errors means it worked
# If you get an error, you may need to update your PSReadline module (see above)


# -------------------------------
# Make it permanent by adding to your profile
# -------------------------------
"Set-PSReadLineOption -PredictionViewStyle ListView" | out-file $profile.CurrentUserAllHosts -append
