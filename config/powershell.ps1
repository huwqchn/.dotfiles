Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
# alias
Set-Alias -Name v -Value nvim
Set-Alias -Name g -Value git
Set-Alias -Name lg -Value lazygit
Set-Alias -Name y -Value yazi
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
