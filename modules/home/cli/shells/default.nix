{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe' getExe;
  bunx' = getExe' pkgs.bun "bunx";
  curl' = getExe pkgs.curl;
in {
  imports = lib.my.scanPaths ./.;
  home.shellAliases = {
    weather = "${curl'} wttr.in";
    gemini = "${bunx'} @google/gemini-cli";
    claude = "${bunx'} @anthropic-ai/claude-code";
    codex = "${bunx'} @openai/codex";
    opencode = "${bunx'} opencode-ai";
  };
}
