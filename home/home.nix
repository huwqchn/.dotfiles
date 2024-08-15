{ myvars, pkgs, ... }: let
  username = myvars.userName;

  homeDirectory = if pkgs.stdenv.isLinux then
    "/home/${username}"
  else
    "/Users/${username}";
in {
  news.display = "show";
  # nix.settings = {
  #   experimental-features = [ "nix-command" "flakes" ];
  #   warn-dirty = false;
  # };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
