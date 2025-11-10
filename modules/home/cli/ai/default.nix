{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = lib.my.scanPaths ./.;
  home.packages = with inputs.nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}; [
    copilot-cli
    cursor-agent
    # BUG: Can't build
    # qwen-code
  ];
}
