# PowerShell 102 - Loops and Logic
# Eric Weintraub - TEC 2025


# -------------------------------
# FOREACH LOOPS
# -------------------------------
# foreach ($loopVar in $RealVar) {<code>}

$CounterForFun = 0 
foreach ($User in ($AllUsers | select -first 5)) {
    # You can put ANYTHING in this loop an it will deal with the $User object
    Write-Host "Counter: $($CounterForFun)" 
    Write-Host "User: $($User.id) - Last Sign-In: $($User.LastSignInDate)"
    $CounterForFun++
}

##################
# Lets get Real... 
# Lets go find active stale devices and disable them
##################
    # Calculate the date 1 year ago
    $OneYearAgo = (Get-Date).AddYears(-1)

    # Find 5 unused devices that are still enabled
    $StaleDevices = $AllDevices | Where-Object {$_.AccountEnabled -eq $true -and $_.ApproximateLastSignInDateTime -lt $OneYearAgo -and $_.ApproximateLastSignInDateTime -ne $null} | sort-object ApproximateLastSignInDateTime | select -first 5

    # Show the 5 devices we found for review
    $StaleDevices | select DisplayName, ApproximateLastSignInDateTime | ft -AutoSize

    # Disable the stale devices (uncomment to execute)

    foreach ($Device in $StaleDevices) {
        write-output "Disabling device: $($Device.DisplayName) last signed in on $($Device.ApproximateLastSignInDateTime)"    
        #Update-MgDevice -DeviceId $Device.Id -AccountEnabled:$false
    }

# -------------------------------
# IF / THEN / ELSE
# -------------------------------
# IF ($something -operator "value") {<then code>} else {<else code>}
# IF / ELSE
$number = 10
if ($number -gt 5) {
    Write-Host "$number is greater than 5"
} else {
    Write-Host "$number is NOT greater than 5"
}


# IF / ELSEIF / ELSE
# IF ($something -operator "value") {<then code>} elseif {<else if code>} else {<else code>}

if ($number -eq 10) {
    Write-Host "$number is exactly 10"
} elseif ($number -lt 10) {
    Write-Host "$number is less than 10"
} else {
    Write-Host "$number is greater than 10"
}


# -------------------------------
# DO / WHILE LOOPS
# -------------------------------
# do {<do code>} while ($something -operator "value")
$i = 1
do {
    Write-Host "Iteration $i"
    $i++
} while ($i -le 5)


# -------------------------------
# MORE DO! Dad Joke API Example
# -------------------------------

$StartTime = Get-Date
$EndTime = $StartTime.AddSeconds(20)
$JokeCount = 1

do {
    # Call the icanhazdadjoke API for a random dad joke
    $JokeResponse = Invoke-RestMethod -Uri "https://icanhazdadjoke.com/" -Headers @{"Accept" = "application/json"}

    # Display the joke with some formatting
    Write-Host "🎭 Dad Joke #$($JokeCount):" -ForegroundColor Cyan
    Write-Host "   $($JokeResponse.joke)" -ForegroundColor White
    Write-Host ""

    
    Write-Host "⏱️  Next joke in 5 seconds..." -ForegroundColor DarkGray
    Start-Sleep -Seconds 5
    $JokeCount++
} while ((Get-Date) -lt $EndTime)

Write-Host "🎉 Dad joke marathon complete! Displayed $($JokeCount - 1) jokes in 60 seconds!" -ForegroundColor Green
Write-Host "Hope you had some laughs! 😄" -ForegroundColor Yellow