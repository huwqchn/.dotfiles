{pkgs, ...}: let
  autolock = "${pkgs.my.zellijPlugins.zellij-autolock}/bin/zellij-autolock.wasm";
in {
  programs.settings = {
    plugins.autolock = {
      _props.location = "file:${autolock}";
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
