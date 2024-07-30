{ pkgs, mylib, ... }: {
  xdg.configFile.wezterm.source = mylib.relativeToConfig "wezterm";
  programs.wezterm = {
    enable = true;
    # install wezterm via homebrew on macOS to avoid compilation, dummy package here.
    package =
      if pkgs.stdenv.isLinux
      then pkgs.wezterm
      else pkgs.hello;
    enableBashIntegration = pkgs.stdenv.isLinux;
    enableZshIntegration = pkgs.stdenv.isLinux;
  };
  
}
