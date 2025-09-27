# PowerShell 103 - Functions and Libraries
# Eric Weintraub - TEC 2025

# -------------------------------
# FUNCTIONS
# -------------------------------
# Functions are reusable blocks of code that can take parameters and return values
function Get-Greeting {
    param (
        [string]$Name = "Guest"
    )
    return "Hello, $Name!"
}
# Call the function
Get-Greeting -Name "TEC"
Get-Greeting

# -------------------------------
# LIBRARIES
# -------------------------------
# Libraries are collections of functions that can be imported and used in your scripts
# Example library file: lib.vscode.ps1
# Use dot-sourcing to import the library
. "$PSScriptRoot/../lib.vscode.ps1"
# Now you can use the functions from the library

