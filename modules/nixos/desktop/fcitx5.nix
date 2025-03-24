{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.my.desktop.fcitx5;
in
{
  options.my.desktop.fcitx5 = {
    enable = mkEnableOption "fcitx5" // {
      default = config.my.desktop.enable;
    };
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
          fcitx5-fluent
        ];
        plasm6Support = true;
        waylandFronted = mkDefault true;
      };
    };

    environment = {
      variables = {
        # fix kitty/wezterm not able to input Chinese
        # https://github.com/kovidgoyal/kitty/issues/403
        GLFW_IM_MODULE = "ibus";
      };
    };
  };
}
