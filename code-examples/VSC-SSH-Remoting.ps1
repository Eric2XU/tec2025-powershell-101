# This really isn't a script, just some recommendations for setting up VS Code SSH Remoting

# For comprehensive documentation, visit: https://code.visualstudio.com/docs/remote/ssh

# -------------------------------
# PREREQUISITES
# -------------------------------
# Install the Remote - SSH extension in VS Code
    # Extension ID: ms-vscode-remote.remote-ssh
    # Install via VS Code Extensions marketplace or command palette (Ctrl+Shift+X)

# Ensure you have an SSH client installed
    # Windows: OpenSSH Client (see Windows SSH setup section below)
    # macOS: SSH is included by default
    # Linux: OpenSSH is typically pre-installed

# -------------------------------
# ENABLING SSH ON WINDOWS
# -------------------------------
# Windows 10 version 1803+ and Windows Server 2019+ include OpenSSH

    # Check if OpenSSH Client is installed
    Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*'

    # Install OpenSSH Client if not present
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

    # Check if OpenSSH Server is installed (for hosting SSH connections)
    Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'

    # Install OpenSSH Server (if you want to SSH INTO this Windows machine)
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

    # Configure so only ./administrators group can SSH in (recommended)
    Write-output "AllowGroups .\administrators" | out-file -Encoding utf8 $env:programdata\ssh\sshd_config -force


    # Start and enable the SSH service (for server functionality)
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'

    # Change the Default Shell to PowerShell (optional but recommended)
    New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force
    # Note: Adjust the path if using Windows PowerShell or a different version

# Notes for Windows SSH Server
# - The Configuration File is located at: C:\ProgramData\ssh\sshd_config
# - Default Port is 22 (change if needed for security)
# - Recommend using firewall to restrict access to ssh to only trusted IPs

# -------------------------------
# VS CODE SSH SETUP
# -------------------------------
# Open VS Code and press Ctrl+Shift+P (Cmd+Shift+P on macOS)
# Type "Remote-SSH: Connect to Host" and select it
# Note: If you didn't install the extension, you won't see this option
# Enter connection string: ssh user@hostname (e.g., bob@192.168.1.100)

# Alternatively, edit SSH config file for easier connections
code ~/.ssh/config
    # Add entries like:
    # Host anyNameWillDo
    #     HostName 192.168.1.100
    #     User bob
    #     Port 22

# -------------------------------
# COMMON SSH CONFIG EXAMPLES
# -------------------------------
# Basic connection
    # Host webserver
    #     HostName example.com
    #     User ubuntu
    #     Port 22

# Connection with specific key
    # Host prodserver
    #     HostName 10.0.1.50
    #     User root
    #     Port 2222
    #     IdentityFile ~/.ssh/prod_key

# Connection through jump host
    # Host internal-server
    #     HostName 192.168.1.100
    #     User admin
    #     ProxyJump jumpbox@gateway.example.com

# -------------------------------
# TROUBLESHOOTING TIPS
# -------------------------------
# Test SSH connection from terminal first
ssh user@hostname

# Check SSH service status on remote Windows machine
Get-Service sshd

# View SSH logs on Windows
Get-WinEvent -LogName "OpenSSH/Operational" | Select-Object -First 10

# Common Windows SSH issues:
    # Firewall blocking port 22: New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH-Server-In-TCP' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    # Default shell not set: New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# VS Code Remote SSH documentation: https://code.visualstudio.com/docs/remote/ssh-tutorial
# Windows OpenSSH documentation: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_overview