#!/usr/bin/env pwsh
<#
.SYNOPSIS
    One-click deployment of configuration files in the config folder + ensure Scoop & apps installed.

.DESCRIPTION
    1. Ensure Scoop is installed.
    2. Ensure certain apps (fastfetch, lazygit, nvim, yazi, etc.) are installed via Scoop.
    3. Copy config files to their respective destinations.

    Adjust the script to match your environment or any custom paths.
#>

# -----------------------------
# 1) Ensure Scoop is installed
# -----------------------------
Write-Host "`n=== 1) Ensure Scoop is installed ==="
Write-Host "Checking if Scoop is installed..."
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop is already installed."
}
else {
    Write-Host "Scoop is not installed. Installing Scoop..."
    # Scoop installation script (requires Set-ExecutionPolicy RemoteSigned or Bypass)
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Write-Host "Scoop installed successfully!"
}

# ------------------------------------------------
# 2) Ensure specific apps are installed via Scoop
# ------------------------------------------------

function Ensure-Bucket {
  param (
    [Parameter(Mandatory = $true)]
    [string]$BucketName,

    [Parameter(Mandatory = $true)]
    [string]$BucketUrl
  )

  Write-Host "Checking if bucket '$BucketName' is added..." -ForegroundColor Cyan
  $buckets = scoop bucket list

  if ($buckets -contains $BucketName) {
      Write-Host "Bucket '$BucketName' is already added.`n" -ForegroundColor Green
  }
  else {
    Write-Host "Adding bucket '$BucketName' from '$BucketURL'..." -ForegroundColor Yellow
    scoop bucket add $BucketName $BucketURL
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Bucket '$BucketName' added successfully.`n" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to add bucket '$BucketName'. Check the URL and try again.`n" -ForegroundColor Red
    }
  }
}

Write-Host "`n=== 2) Add buckets if needed ==="
Ensure-Bucket "extras"
Ensure-Bucket "nerd-fonts"


function Ensure-App {
  param (
    [Parameter(Mandatory = $true)]
    [string]$AppName
  )
  Write-Host "Checking if app '$AppName' is installed via Scoop..." -ForegroundColor Cyan
  if (scoop list | Select-String -Pattern "^\s*$AppName\s") {
    Write-Host "App '$AppName' is already installed.`n" -ForegroundColor Green
  }
  else {
    Write-Host "App '$AppName' is not installed. Installing now..." -ForegroundColor Yellow
    scoop install $AppName
    if ($LASTEXITCODE -eq 0) {
        Write-Host "App '$AppName' installed successfully.`n" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to install app '$AppName'. Check if the bucket containing '$AppName' is added.`n" -ForegroundColor Red
    }
  }
}

Write-Host "`n=== 3) Install app if needed ==="
Ensure-App "fd"
Ensure-App "7zip"
Ensure-App "gcc"
ensure-app "git"
Ensure-App "extra/lazygit"
Ensure-App "extras/glazewm"
Ensure-App "extras/zebar"
Ensure-App "neovim"
Ensure-App "starship"
Ensure-App "yazi"
Ensure-App "fastfetch"
Ensure-App "bat"
Ensure-App "ripgrep"
Ensure-App "cmake"
Ensure-App "gh"
Ensure-App "unzip"
Ensure-App "innounp"
Ensure-App "tree-sitter"
Ensure-App "eza"
Ensure-App "neovim"
Ensure-App "nodejs"
Ensure-App "luarocks"
Ensure-App "jq"
Ensure-App "btop"
Ensure-App "zoxide"
Ensure-App "imagemagick"
Ensure-App "fzf"
Ensure-App "lua"
Ensure-App "starship"
Ensure-App "nerd-fonts/CascadiaCode-NF"
Ensure-App "nerd-fonts/JetBrainsMono-NF"

# ------------------------------------------------
# 3) Copy configuration files to their destinations
# ------------------------------------------------
Write-Host "`n=== 3) Copying configuration files ==="
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
