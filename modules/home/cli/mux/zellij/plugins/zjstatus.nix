{pkgs, ...}: let
  zjstatusWasm = "${pkgs.zjstatus}/bin/zjstatus.wasm";
in {
  programs.zellij.settings.plugins.zjstatus = {
    _props.location = "file:${zjstatusWasm}";
  };
}
