{
  pkgs,
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
}
