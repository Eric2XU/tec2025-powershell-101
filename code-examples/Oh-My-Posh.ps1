# Oh-My-Posh setup Script
# https://ohmyposh.dev/docs/

# This script is not intended to be run as a script
# It is just a set of commands to run in the terminal depending on your environment
# Don't forget this is per instance of PowerShell, so you do have to do this twice, once for PowerShell for Windows (PowerShell.exe) and once for PowerShell Core (pwsh.exe)

# -------------------------------
# OH-MY-POSH
# -------------------------------
# Install the Oh-My-Posh binary

    ##########
    # WINDOWS 
    ##########
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

    ##########
    # MACOS
    ##########
    # Run the following command in your terminal
    brew install jandedobbeleer/oh-my-posh/oh-my-posh

    ##########
    # LINUX
    ##########
    # Run the following command in your terminal
    curl -s https://ohmyposh.dev/install.sh | bash

# Restart your terminal after installing

# Install a Nerd Font
    # Notes about Fonts:
        # You must install a Nerd Font to see all the glyphs/icons, I always like to use Cascadia Code but you can't use the Microsoft one, you have to use the one from Oh-My-Posh to ensure you get all the glyphs
        # Oh-my-posh calls it Cascadia Code in the font install menu but its actually called CaskaydiaCover Nerd Font or something like that so be aware
    oh-my-posh font install CascadiaCode

    # Alternatively, you can run the following to pick a font from a menu
    oh-my-posh font install

# Set your Terminal to use the new Font

    ##########
    # WINDOWS 
    ##########
    # Open Windows Terminal Settings (Ctrl+,)
    # Select the Profile you want to change (e.g. PowerShell, pwsh,or default)
    # Under Appearance, change the Font face to the Nerd Font you installed (e.g. CaskaydiaCove Nerd Font)
    # Save the settings (Ctrl+S)    

    ##########
    # MACOS
    ##########
    # Open iTerm2 Preferences (Cmd+,)
    # Go to Profiles, then Text
    # Change the Font to the Nerd Font you installed (e.g. Caskaydia Cover Nerd Font)
    # Close Preferences 
    
    ##########
    # LINUX
    ##########
    # This will depend on your terminal, but generally you want to go to Preferences, then Profiles, then Text, and change the Font to the Nerd Font you installed (e.g. Caskaydia Cover Nerd Font)

# Verification: Initialize Oh-My-Posh
oh-my-posh init pwsh | Invoke-Expression

# if that worked, you should put it in your profile to make it permanent
"oh-my-posh init pwsh | Invoke-Expression" | out-file $profile.CurrentUserAllHosts -append

# Cool I hope it worked, if not see the docs at https://ohmyposh.dev/docs/ or talk to ChatGPT or Copilot, you will get there. 

# Next up, customizing your prompt. Use one of the themes from https://ohmyposh.dev/docs/themes or create your own.
