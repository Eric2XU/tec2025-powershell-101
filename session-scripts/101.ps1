# PowerShell 101 - Basics
# Eric Weintraub - TEC 2025

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
# Querying / Filtering Objects
# -------------------------------

# List all users
$users

# List first 2 users
$users | Select-Object -First 2

# List Last 2 users
$users | Select-Object -Last 2

# List all user names
$users.Name

# List all active users
$AllActiveUsers = $users | Where-Object { $_.Active -eq $true }

# List all users with a specific role
$AllEngineers = $users | Where-Object { $_.Role -like "Eng*" } | Sort-Object Name

# Disable Eric and re-enable Eric
$Eric = $users | Where-Object { $_.Name -eq "Eric" }
$Eric.Active = $false
$Eric
$Eric.Active = $true