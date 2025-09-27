function Get-VSCodeSettingsPath {
    if ($IsMacOS) {
        return "$HOME/Library/Application Support/Code/User/settings.json"
    }
    elseif ($IsLinux) {
        return "$HOME/.config/Code/User/settings.json"
    }
    elseif ($IsWindows) {
        return "$env:APPDATA\Code\User\settings.json"
    }
    else {
        throw "Unsupported OS. Where the hell are you running this?"
    }
}
function Set-VSTerminalFontSize {
    param (
        [Parameter(Mandatory = $true)]
        [int]$FontSize
    )

    try {
        $settingsPath = Get-VSCodeSettingsPath

        if (-not (Test-Path $settingsPath)) {
            Write-Error "VS Code settings.json not found at $settingsPath"
            return
        }

        # Read, update, and save
        $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $json."terminal.integrated.fontSize" = $FontSize
        $json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8

        Clear-Host
    }
    catch {
        Write-Error "Failed to update VS Code settings: $_"
    }
}

function Set-VSCodeEditorFontSize {
    param (
        [Parameter(Mandatory = $true)]
        [int]$FontSize
    )

    try {
        $settingsPath = Get-VSCodeSettingsPath

        if (-not (Test-Path $settingsPath)) {
            Write-Error "VS Code settings.json not found at $settingsPath"
            return
        }

        $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $json."editor.fontSize" = $FontSize
        $json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8

        Clear-Host
    }
    catch {
        Write-Error "Failed to update VS Code settings: $_"
    }
}