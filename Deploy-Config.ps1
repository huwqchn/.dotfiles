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

function Add-Bucket {
  param (
    [Parameter(Mandatory = $true)]
    [string]$BucketName
  )
  Write-Host "Checking if bucket '$BucketName' is added..." -ForegroundColor Cyan
  $buckets = scoop bucket list | Select-Object -ExpandProperty Name
  if ($buckets -contains $BucketName) {
    Write-Host "Bucket '$BucketName' is already added.`n" -ForegroundColor Green
  }
  else {
    Write-Host "Adding bucket '$BucketName' ..." -ForegroundColor Yellow
    scoop bucket add $BucketName
    if ($LASTEXITCODE -eq 0) {
      Write-Host "Bucket '$BucketName' added successfully.`n" -ForegroundColor Green
    }
    else {
      Write-Host "Failed to add bucket '$BucketName'.`n" -ForegroundColor Red
    }
  }
}

Write-Host "`n=== 2) Add buckets if needed ==="
$requiredBuckets = @("main", "extras", "nerd-fonts") # Add more bucket names as needed

foreach ($bucket in $requiredBuckets) {
  Add-Bucket $bucket
}

function Install-App {
  param (
    [Parameter(Mandatory = $true)]
    [string]$AppName
  )
  Write-Host "Checking if app '$AppName' is installed via Scoop..." -ForegroundColor Cyan
  $apps = scoop list | Select-Object -ExpandProperty Name
  if ($apps -contains $AppName) {
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
$requiredApps = @(
  "fd",
  "7zip",
  "gcc",
  "git",
  "lazygit",
  "glazewm",
  "zebar",
  "powertoys",
  "neovim",
  "starship",
  "yazi",
  "fastfetch",
  "bat",
  "ripgrep",
  "cmake",
  "gh",
  "unzip",
  "innounp",
  "tree-sitter",
  "eza",
  "neovim",
  "nodejs",
  "luarocks",
  "jq",
  "btop",
  "zoxide",
  "imagemagick",
  "fzf",
  "lua",
  "starship",
  "kanata",
  "CascadiaCode-NF",
  "JetBrainsMono-NF"
  "CascadiaCode-NF-Mono",
  "JetBrainsMono-NF-Mono"
)

foreach ($app in $requiredApps) {
  Install-App $app
}

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
# GlazeWM
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

# ----------------
# windows terminal settings
# ----------------
If (Test-Path ".\config\windows_terminal_settings.json") {
  Write-Host "Detected windows_terminal_settings.json file. Preparing to copy..."
  # The Windows Terminal settings file is generally at $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" | Out-Null
  # Copy the file as settings.json
  Copy-Item -Path ".\config\windows_terminal_settings.json" `
            -Destination "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
            -Force
  Write-Host "windows_terminal_settings.json configuration copied successfully!"
}
Else {
  Write-Host "No windows_terminal_settings.json detected. Skipping..."
}

# ----------------
# kanata
# ----------------
If (Test-Path ".\config\kanata\config.kbd") {
  Write-Host "Detected kanata configuration file. Preparing to copy..."
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\kanata" | Out-Null
  Copy-Item -Path ".\config\kanata\config.kbd" `
            -Destination "$env:USERPROFILE\.config\kanata\config.kbd" `
            -Force
  Write-Host "kanata configuration copied successfully!"
}
Else {
  Write-Host "No kanata configuration detected. Skipping..."
}

Write-Host "`nAll configurations have been copied!"
