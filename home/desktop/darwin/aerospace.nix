{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop;
  inherit (lib) mkIf;
in {
  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    home.file.".aerospace.toml".source =
      config.lib.file.mkOutOfStoreSymlink
      (lib.my.relativeToConfig "aerospace.toml");
  };
}
