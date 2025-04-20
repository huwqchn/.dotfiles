{
  config,
  lib,
  ...
}: let
  username = config.my.name;
  homeDirectory = config.my.home;
  inherit (lib.modules) mkDefault;
in {
  imports = [
    # common options defined both user level and system level
    ../common/my
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
