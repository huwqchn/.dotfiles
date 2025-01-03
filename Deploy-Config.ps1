#!/usr/bin/env pwsh
<#
.SYNOPSIS
    One-click deployment of configuration files in the config folder to their corresponding directories.

.DESCRIPTION
    - fastfetch        -> $HOME\.config\fastfetch
    - lazygit          -> $HOME\.config\lazygit
    - nvim             -> $HOME\AppData\Local\nvim
    - yazi             -> $HOME\.config\yazi
    - starship.toml    -> $HOME\.config\starship.toml
    - powershell.ps1   -> $HOME\Documents\PowerShell\profile.ps1

    If the script or target paths differ from your environment,
    please adjust the script accordingly.
#>

Write-Host "`nStarting to copy configuration files..."

# ----------------
# fastfetch
# ----------------
If (Test-Path ".\config\fastfetch") {
    Write-Host "Detected fastfetch configuration folder. Preparing to copy..."
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\fastfetch" | Out-Null
    Copy-Item -Path ".\config\fastfetch\*" `
               -Destination "$env:USERPROFILE\.config\fastfetch" `
               -Recurse -Force
    Write-Host "fastfetch configuration copied successfully!"
}
Else {
    Write-Host "No fastfetch configuration detected. Skipping..."
}

# ----------------
# lazygit
# ----------------
If (Test-Path ".\config\lazygit") {
    Write-Host "Detected lazygit configuration folder. Preparing to copy..."
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\AppData\Local\lazygit" | Out-Null
    Copy-Item -Path ".\config\lazygit\*" `
               -Destination "$env:USERPROFILE\AppData\Local\lazygit" `
               -Recurse -Force
    Write-Host "lazygit configuration copied successfully!"
}
Else {
    Write-Host "No lazygit configuration detected. Skipping..."
}

# ----------------
# nvim
# ----------------
If (Test-Path ".\config\nvim") {
    Write-Host "Detected nvim configuration folder. Preparing to copy..."
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\AppData\Local\nvim" | Out-Null
    Copy-Item -Path ".\config\nvim\*" `
               -Destination "$env:USERPROFILE\AppData\Local\nvim" `
               -Recurse -Force
    Write-Host "nvim configuration copied successfully!"
}
Else {
    Write-Host "No nvim configuration detected. Skipping..."
}

# ----------------
# yazi
# ----------------
If (Test-Path ".\config\yazi") {
    Write-Host "Detected yazi configuration folder. Preparing to copy..."
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\AppData\Roaming\yazi\config" | Out-Null
    Copy-Item -Path ".\config\yazi\*" `
               -Destination "$env:USERPROFILE\AppData\Roaming\yazi\config" `
               -Recurse -Force
    Write-Host "yazi configuration copied successfully!"
}
Else {
    Write-Host "No yazi configuration detected. Skipping..."
}

# ----------------
# starship.toml
# ----------------
If (Test-Path ".\config\starship.toml") {
    Write-Host "Detected starship.toml file. Preparing to copy..."
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config" | Out-Null
    Copy-Item -Path ".\config\starship.toml" `
               -Destination "$env:USERPROFILE\.config\starship.toml" `
               -Force
    Write-Host "starship.toml copied successfully!"
}
Else {
    Write-Host "No starship.toml detected. Skipping..."
}

# ----------------
# powershell.ps1
# ----------------
If (Test-Path ".\config\glazewm.yaml") {
    Write-Host "Detected glazewm.yaml file. Preparing to copy..."
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config" | Out-Null
    Copy-Item -Path ".\config\glazewm.yaml" `
               -Destination "$env:USERPROFILE\.config\glazewm.yaml" `
               -Force
    Write-Host "glazewm.yaml copied successfully!"
}
Else {
    Write-Host "No glazewm.yaml detected. Skipping..."
}

# ----------------
# powershell.ps1
# ----------------
If (Test-Path ".\config\powershell.ps1") {
    Write-Host "Detected powershell.ps1 file. Preparing to copy..."
    # The PowerShell configuration folder is generally at $HOME\Documents\PowerShell for the current user
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\Documents\PowerShell" | Out-Null
    # Copy the file as profile.ps1, i.e., the global config for the current user
    Copy-Item -Path ".\config\powershell.ps1" `
               -Destination "$env:USERPROFILE\Documents\PowerShell\profile.ps1" `
               -Force
    Write-Host "powershell.ps1 configuration copied successfully!"
}
Else {
    Write-Host "No powershell.ps1 detected. Skipping..."
}

Write-Host "`nAll configurations have been copied!"
