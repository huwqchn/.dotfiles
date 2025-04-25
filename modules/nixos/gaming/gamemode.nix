{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.my) isHyprland;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (lib.strings) optionalString makeBinPath;
  inherit (lib.meta) getExe';
  notify-send' = getExe' pkgs.libnotify "notify-send";

  isHyprland' = isHyprland config;

  programs = makeBinPath (builtins.attrValues {inherit (pkgs) hyprland coreutils systemd;});

  startscript = pkgs.writeShellScript "gamemode-start" ''
    ${optionalString isHyprland' ''
      export PATH=$PATH:${programs}
      export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)
      hyprctl --batch 'keyword decoration:blur 0 ; keyword animations:enabled 0 ; keyword misc:vfr 0'
    ''}

    ${notify-send'} -a 'Gamemode' 'Optimizations activated'
  '';

  endscript = pkgs.writeShellScript "gamemode-end" ''
    ${optionalString isHyprland' ''
      export PATH=$PATH:${programs}
      export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)
      hyprctl --batch 'keyword decoration:blur 1 ; keyword animations:enabled 1 ; keyword misc:vfr 1'
    ''}

      ${notify-send'} -a 'Gamemode' 'Optimizations deactivated'
  '';

  cfg = config.my.game;
in {
  options.my.game = {
    enable = mkEnableOption "Gamescope compositing manager";
  };

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
        custom = {
          start = startscript.outPath;
          end = endscript.outPath;
        };
      };
    };
  };
}
