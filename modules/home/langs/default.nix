{lib, ...}: {
  imports = lib.my.scanPaths ./.;

  options.my.develop = {
    enable =
      lib.mkEnableOption "development environment"
      // {
        default = true;
      };
  };
}
