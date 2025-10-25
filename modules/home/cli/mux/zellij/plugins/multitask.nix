{
  config,
  pkgs,
  ...
}: let
  multitask = "${pkgs.my.zellijPlugins.multitask}/bin/multitask.wasm";
in {
  programs.settings = {
    plugins.autolock = {
      _props.location = "file:${multitask}";
      _children = [
        {
          shell = config.my.shell.exec;
        }
      ];
    };
  };
}
