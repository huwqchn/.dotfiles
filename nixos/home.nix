{ config, ... }: {
  news.display = "show";
  
  # nix.settings = {
  #   experimental-features = [ "nix-command" "flakes" ];
  #   warn-dirty = false;
  # };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
