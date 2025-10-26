{pkgs, ...}: let
  autolock = "file:${pkgs.my.zellij-autolock}/bin/zellij-autolock.wasm";
in {
  programs.zellij.settings = {
    plugins.autolock = {
      _props.location = autolock;
      _children = [
        {
          is_enabled = true;
        }
        {
          triggers = "nvim|vim|git";
        }
        {
          reaction_seconds = "0.3";
        }
        {
          print_to_log = true;
        }
      ];
    };
    load_plugins.autolock = {};
  };
}
