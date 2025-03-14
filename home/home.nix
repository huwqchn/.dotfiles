{
  inputs,
  config,
  lib,
  ...
}: let
  username = config.my.name;
  homeDirectory = config.my.home;
  inherit (config.my.machine) persist;
in {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    ../modules/common/my.nix
  ];

  news.display = "show";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;
    sessionPath = ["$HOME/.local/bin" "/opt/homebrew/bin"];

    persistence =
      if persist
      then {
        "/persist/${config.home.homeDirectory}" = {
          directories = [
            "Downloads"
            "Documents"
            "Desktop"
            "Music"
            "Videos"
            "Public"
            "Templates"
            "Pictures"
            ".local/bin"
            ".cache/nix"
            ".cache/pre-commit"
            ".dotfiles"
            ".docker"
          ];
          allowOther = true;
        };
      }
      else lib.mkForce {};

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = lib.mkDefault "24.11";
  };

  programs.home-manager.enable = true;
}
