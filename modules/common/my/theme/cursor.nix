{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) str nullOr package submodule int;
in {
  options.my.theme.cursor = mkOption {
    description = ''
      Attributes defining the systemwide cursor. Set either all or none of
      these attributes.
    '';
    type = nullOr (
      submodule {
        options = {
          name = mkOption {
            description = "The cursor name within the package.";
            type = nullOr str;
            default = null;
          };
          package = mkOption {
            description = "Package providing the cursor theme.";
            type = nullOr package;
            default = null;
          };
          size = lib.mkOption {
            description = "The cursor size.";
            type = nullOr int;
            default = null;
          };
        };
      }
    );
    default = null;
  };
  config.assertions = let
    inherit (config.my.theme) cursor;
  in [
    {
      assertion =
        cursor
        == null
        || cursor.name != null && cursor.package != null && cursor.size != null;
      message = ''
        Error: `my.theme.cursor` is only partially defined. Set either none or
        all of the `my.theme.cursor` options.
      '';
    }
  ];
}
