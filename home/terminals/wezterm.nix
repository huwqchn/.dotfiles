{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.wezterm;
in {
  options.my.wezterm = {enable = mkEnableOption "wezterm";};

  config = mkIf cfg.enable {
    programs.wezterm = {enable = true;};
    xdg.configFile."wezterm" = {
      recursive = true;
      source = lib.my.relativeToConfig "wezterm";
    };
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".cache/wezterm" ".local/share/wezterm"];
    };
  };
}
