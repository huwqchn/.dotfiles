{
  config,
  lib,
  ...
} @ args:
with lib; let
  cfg = config.modules.desktop.hyprland;
in {
  imports = [
    ./options
  ];

  options.modules.desktop.hyprland = {
    enable = mkEnaleOption "hyprland compositor";
    settings = lib.mkOption {
      type = with lib.types; let
        valueType =
          nullor (oneOf [
            bool
            int
            float
            str
            path
            (attrsOf valueType)
            (listOf valueType)
          ])
          // {
            description = "Hyprland configuration value";
          };
      in
        valueType;
      default = {};
    };
  };

  config = mkIf cfg.enable (
    mkMerge ([
      {
        wayland.windowManager.hyprland.settings = cfg.settings;
      }
    ]
    ++ (import ./values args))
  );
}
