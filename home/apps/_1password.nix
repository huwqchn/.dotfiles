{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    _1password
    _1password-gui
  ];
}
