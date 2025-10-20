{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = lib.my.scanPaths ./.;
  home.packages = with inputs.nix-ai-tools.packages.${pkgs.system}; [
    copilot-cli
    cursor-agent
    qwen-code
  ];
}
