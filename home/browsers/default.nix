{lib, ...}: let
  inherit (lib) mkOption types;
  # browser = config.my.browser;
in {
  imports = lib.my.scanPaths ./.;

  options.my.browser = mkOption {
    type = types.enum ["firefox" "chrom" "zen"];
    default = "zen";
    description = "The browser to use";
  };
}
