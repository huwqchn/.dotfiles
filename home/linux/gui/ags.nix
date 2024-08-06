{
  pkgs,
  mylib,
  system,
  ags,
  matugen,
  ...
}: {
  imports = [
    ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    swww
    matugen.packages.${system}.default
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
  ];

  programs.ags = {
    enable = true;
    configDir = mylib.relativeToConfig "ags";
    extraPackages = with pkgs; [
      accountsservice
    ];
  };
}
