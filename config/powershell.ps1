Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
# set nvim as default editor
Set-Item Env:EDITOR nvim
# alias
Set-Alias -Name v -Value nvim
Set-Alias -Name g -Value git
Set-Alias -Name lg -Value lazygit
Set-Alias -Name c -Value Clear-Host
Set-Alias -Name top -Value btop
Set-Alias -Name du -Value dust
Set-Alias -Name reboot -Value Restart-Computer
Set-Alias -Name shutdown -Value Stop-Computer
Set-Alias -Name cat -Value bat
#Set-Alias -Name y -Value yazi

# yazi
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
# eza aliases
Set-Alias -Name ls -Value new_ls
Set-Alias -Name la -Value new_la
Set-Alias -Name lsa -Value new_la
Set-Alias -Name ll -Value new_ll
Set-Alias -Name lla -Value new_lla
Set-Alias -Name lah -Value new_lah

function new_ls { eza --color=always --icons=always --group-directories-first @args }
function new_la { eza -a --color=always --icons=always --group-directories-first @args }
function new_ll { eza -l --no-permissions --no-filesize --no-time --no-user --color=always --icons=always --group-directories-first @args }
function new_lla { eza -la --no-permissions --no-filesize --no-time --no-user --color=always --icons=always --group-directories-first @args }
function new_lah { eza -lah --color=always --icons=always --group-directories-first @args }

Set-Alias -Name tree -Value new_tree
Set-Alias -Name treea -Value new_treea
Set-Alias -Name treel -Value new_treel
Set-Alias -Name treela -Value new_treela

function new_tree { eza --tree --level=2 --color=always --icons=always --group-directories-first @args }
function new_treea { eza --tree -a --level=2 --color=always --icons=always --group-directories-first @args }
function new_treel { eza --tree --color=always --icons=always --group-directories-first @args }
function new_treela { eza --tree -a --color=always --icons=always --group-directories-first @args }
# Fzf
# FZF config
# Enable fd integration
# $env:FZF_DEFAULT_COMMAND='fd --type=f --strip-cwd-prefix --hidden --follow --exclude .git'
# $env:FZF_CTRL_T_COMMAND=$env:FZF_DEFAULT_COMMAND
# $env:FZF_ALT_C_COMMAND='fd --type=d --strip-cwd-prefix --hidden --follow --exclude .git'
# Use bat to show file preview
# $env:FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
# $env:FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {}'"
# Customise the look of fzf

# $env:FZF_DEFAULT_OPTS="
#  --highlight-line \
#  --info=inline-right \
#  --ansi \
#  --layout=reverse \
#  --border=none \
#  --color=bg+:#2d3f76 \
#  --color=bg:#1e2030 \
#  --color=border:#589ed7 \
#  --color=fg:#c8d3f5 \
#  --color=gutter:#1e2030 \
#  --color=header:#ff966c \
#  --color=hl+:#65bcff \
#  --color=hl:#65bcff \
#  --color=info:#545c7e \
#  --color=marker:#ff007c \
#  --color=pointer:#ff007c \
#  --color=prompt:#65bcff \
#  --color=query:#c8d3f5:regular \
#  --color=scrollbar:#589ed7 \
#  --color=separator:#ff966c \
#  --color=spinner:#ff007c \
#  "

# prompt
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}
# keybindings
Set-PSReadlineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit
Set-PSReadlineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadlineKeyHandler -Chord Ctrl+e -Function EndOfLine
fastfetch
