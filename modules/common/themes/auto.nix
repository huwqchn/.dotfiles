{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.themes.auto;
in {
  config = mkIf cfg.enable {
    assertions = [
      (mkIf (config.my.wallpaper == null)
        {
          assertion = false;
          message = ''
            The image option is required when using the auto theme.
          '';
        })
    ];
    stylix = {
      autoEnable = true;
      polarity = cfg.style;
      base16Scheme = null;
    };
  };
}
