{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  zjstatusWasm = "${inputs.zjstatus.packages.${system}}/bin/zjstatus.wasm";
in {
  programs.zellij.settings.plugins.zjstatus = {
    _props.location = "file:${zjstatusWasm}";
  };
}
