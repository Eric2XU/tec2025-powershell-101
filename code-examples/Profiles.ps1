# PowerShell Profiles 101
# Eric Weintraub - TEC 2025

# -------------------------------
# PROFILES
# -------------------------------
# PowerShell profiles are scripts that run when you start a new PowerShell session
# You can use profiles to customize your environment, load modules, set aliases, and more
# There are several different profiles, but I recommend the CurrentUserAllHosts profile

# Here is how you see where all your profiles are located
$profile | select *

# quick way to take a peek at your profile
cat $PROFILE.CurrentUserAllHosts

# or if you have code just call it 
code $PROFILE.CurrentUserAllHosts

# If you want to add something to your profile do this: 
"Write-Host 'Hello, PowerShell Profile!'" | out-file $profile.CurrentUserAllHosts -append

# More real world examples:
"Set-PSReadLineOption -PredictionViewStyle ListView" | out-file $profile.CurrentUserAllHosts -append
"oh-my-posh init pwsh | Invoke-Expression" | out-file $profile.CurrentUserAllHosts -append