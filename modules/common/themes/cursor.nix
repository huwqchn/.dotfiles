{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.themes) cursor;
in {
  config = mkIf (cursor != null) {
    environment = {
      systemPackages = [cursor.package];
      variables = {
        XCURSOR_THEME = cursor.name;
        XCURSOR_SIZE = toString cursor.size;
      };
    };
  };
}
