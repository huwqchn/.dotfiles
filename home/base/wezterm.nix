{ pkgs, mylib, ... }: {
  enable = true; # disable

  # install wezterm via homebrew on macOS to avoid compilation, dummy package here.
  package =
    if pkgs.stdenv.isLinux
    then pkgs.wezterm
    else pkgs.hello;
  extraConfig = builtins.readFile (mylib.RelativeToConfig "wezterm/wezterm.lua");
}
