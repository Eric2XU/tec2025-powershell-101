# PowerShell 102 - Loops and Logic
# Eric Weintraub - TEC 2025

# -------------------------------
# IF / THEN / ELSE
# -------------------------------
$number = 10
if ($number -gt 5) {
    Write-Host "$number is greater than 5"
}
else {
    Write-Host "$number is NOT greater than 5"
}
if ($number -eq 10) {
    Write-Host "$number is exactly 10"
}
elseif ($number -lt 10) {
    Write-Host "$number is less than 10"
}
else {
    Write-Host "$number is greater than 10"
}
# -------------------------------
# FOREACH LOOPS
# -------------------------------
$colors = @("Red", "Green", "Blue")
foreach ($color in $colors) {
    Write-Host "Color: $color"
}
# -------------------------------
# DO / WHILE LOOPS
# -------------------------------
$i = 1
do {
    Write-Host "Iteration $i"
    $i++
} while ($i -le 5)

