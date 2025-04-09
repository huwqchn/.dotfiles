{
  inputs,
  config,
  lib,
  ...
}: let
  username = config.my.name;
  homeDirectory = config.my.home;
  inherit (lib) mkDefault;
in {
  imports = [
    ../modules/common/my.nix
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
    ../modules/common/agenix.nix
  ];

  news.display = "show";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;
    sessionPath = ["$HOME/.local/bin" "/opt/homebrew/bin"];
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = mkDefault "24.11";
  };

  programs.home-manager.enable = true;
}
