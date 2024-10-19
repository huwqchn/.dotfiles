{
  pkgs,
  config,
  ags,
  mylib,
  matugen,
  ...
}: {
  imports = [
    ags.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    bun
    dart-sass
    hyprpicker
    matugen.packages.${pkgs.system}.default
    swww
    brightnessctl
    slurp
    fortune
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
