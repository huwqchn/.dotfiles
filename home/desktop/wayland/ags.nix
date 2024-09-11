{
  pkgs,
  config,
  ags,
  mylib,
  ...
}: {
  imports = [
    ags.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    bun
    dart-sass
    hyprpicker
  ];
  programs.ags = {
    enable = true;
    configDir = mylib.relativeToConfig "ags";
    extraPackages = with pkgs; [
      accountsservice
    ];
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".cache/ags"
      ".local/share/com.github.Aylur.ags"
    ];
  };
}
