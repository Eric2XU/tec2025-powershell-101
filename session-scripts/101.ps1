# PowerShell 101 - Basics
# Eric Weintraub - TEC 2025


#region Real World DataSets for examples

# Real World DataSets for examples
Connect-MgGraph -Scopes "User.Read.All","Application.Read.All","Policy.Read.All","AuditLog.Read.All","DeviceManagementConfiguration.Read.All","DeviceManagementManagedDevices.Read.All"

# Pull Basic User Data along with SignInActivity for a single user
$allUsers = Get-MgUser -all -Property id, SignInActivity, UserType, AccountEnabled, Department, DisplayName, Id, OnPremisesSyncEnabled, Country,OfficeLocation | Select-Object id, DisplayName, UserType, AccountEnabled, Department, @{Name="LastSignInDate";Expression={ $_.SignInActivity.LastSignInDateTime }}, OnPremisesSyncEnabled, Country, OfficeLocation

$AllDevices = Get-MgDevice -All | select AccountEnabled, ApproximateLastSignInDateTime, DeviceId, DeviceOwnership, DisplayName, EnrollmentType, Id, IsCompliant, IsManaged, IsRooted, ManagementType, Manufacturer, Model, OperatingSystem, ProfileType

# Export all of the above data sets to JSON files just in case internet isnt working during the session
$AllUsers | ConvertTo-Json -Depth 3 | Out-File "~\temp\AllUsers.json" -Force
$AllDevices | ConvertTo-Json -Depth 3 | Out-File "~\temp\AllIntuneDevices.json" -Force

# Import the data sets from JSON files if needed
$AllUsers = Get-Content "~\temp\AllUsers.json" | ConvertFrom-Json
$AllDevices = Get-Content "~\temp\AllDevices.json" | ConvertFrom-Json

#endregion


# -------------------------------
# VARIABLES
# -------------------------------
# Variables are declared using the $ symbol
$greeting = "Hello TEC"
$number = 2025

# Output the variables
Write-Host $greeting
Write-Host $number

# You can concatenate variables (Notice that powershell tries really hard to make sense of less then perfectly defined intent)
$greeting + $number
$greeting + "" + $number
$greeting + " " + $number

# -------------------------------
# SINGLE QUOTES vs DOUBLE QUOTES & STRINGS vs INTEGERS
# -------------------------------

# Math: 2 + 2 always equals 4?
2 + 2
2MB * 10MB
"2" + "2"
'2' + '2'
"2" + 2
"2" + "two"
"two" + 2
2 + "two"

# Why casting matters
[int]"2" + [int]"2"
[int]"2" + "2"

# See if its a string or an integer
$number | gm
$greeting | gm

# Single vs Double Quotes
Write-Host 'Our Greeting is: $greeting $number'    # Single quotes do not expand variables
Write-Host "Our Greeting is: $greeting $number"    # Double quotes do expand variables

# Proper use of a var in a string
Write-Host "Our Greeting is: $($greeting) $($number)"  
Write-Host "Our Greeting is: $($greeting + $number+1000)"  
Write-Host "Our Greeting is: $($greeting + [int]$number+1000)"
Write-Host "Our Greeting is: $($greeting + ($number+1000))" # Correctly adds 1000 to number before concatenation

# -------------------------------
# ARRAYS
# -------------------------------
# Arrays hold multiple values 
$colors = @("Red", "Green", "Blue")
Write-Host $colors[0]   # Output: Red
Write-Host $colors[1]   # Output: Green
Write-Host $colors[2]   # Output: Blue

# TIP: Notice it is zero based indexing meaning the first item is index 0


# -------------------------------
# Piping
# -------------------------------
# Piping passes output from one command to another
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

# -------------------------------
# PSCustomObject
# -------------------------------

$users = @(
    [PSCustomObject]@{Name="Eric"; Role="IT Manager"; Location="Remote"; Active=$true}
    ,[PSCustomObject]@{Name="Sam"; Role="Intern"; Location="Boston"; Active=$true}
    ,[PSCustomObject]@{Name="Nicole"; Role="Engineer"; Location="Remote"; Active=$false}
    ,[PSCustomObject]@{Name="Jon"; Role="Engineer"; Location="NYC"; Active=$true}
    ,[PSCustomObject]@{Name="Christian"; Role="IT Manager"; Location="Remote"; Active=$true}
)


# -------------------------------
# Querying / Selecting Objects
# -------------------------------

# List all users
$allUsers


# List first 5 users
$AllUsers | select -first 5
$AllUsers | select -first 5 | ft -AutoSize


# List Last 2 users
$AllUsers | Select-Object -Last 2

# List all user names
$AllUsers.DisplayName

# Count All Users
$AllUsers.Count
$AllUsers | Measure-Object
$AllUsers | Measure-Object | Select-Object Count

# Group all users by type
$AllUsers | Group-Object UserType

# -------------------------------
# WHERE / FILTERING
# -------------------------------

# List a single device so we can take a look at the data 
$AllDevices | select -first 1

# all active devices
$AllDevices | Where-Object { $_.AccountEnabled -eq $true } 

# count of all active devices
$AllDevices | Where-Object { $_.AccountEnabled -eq $true } | Measure-Object | Select-Object Count

# Devices Grouped by Model
$AllDevices | Group-Object Model | Sort-Object Count
$AllDevices | Group-Object Model | select -first 5 | Sort-Object Count
$AllDevices | Group-Object Model | Sort-Object Count -Descending | select -first 5 
$AllDevices | Group-Object Model | ? {$_.Model -ne ""} | Sort-Object Count -Descending | select -first 5
$AllDevices | Group-Object Model | ? {$_.Name -ne ""} | Sort-Object Count -Descending | select -first 5
$AllDevices | Group-Object Model | ? {$_.Name -ne ""} | Sort-Object Count -Descending | select -first 5 | ft Name, Count -AutoSize

# List all Latitude devices
$AllDevices | Where-Object { $_.Model -like "Latitude*" } | select DisplayName, DeviceOwnership, Model, OperatingSystem, ApproximateLastSignInDateTime | Sort-Object ApproximateLastSignInDateTime | select -First 5| ft -AutoSize 
$AllDevices | Where-Object { $_.Model -like "Latitude*" } | ? {$_.ApproximateLastSignInDateTime -ne $null}| select DisplayName, DeviceOwnership, Model, OperatingSystem, ApproximateLastSignInDateTime, AccountEnabled | Sort-Object ApproximateLastSignInDateTime | select -First 5| ft -AutoSize 
