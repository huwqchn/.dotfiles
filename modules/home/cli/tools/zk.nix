{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.my.zk;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.zk = {
    enable = mkEnableOption "zk";
  };
  config = mkIf cfg.enable {
    programs.zk = {
      enable = true;
      settings = {
        notebook.dir = "~/Documents/Notes";
        note = {
          template = "default.md";
          filename = "{{slug title}}";
        };

        format.markdown = {
          link-format = "wiki";
          hashtags = true;
          colon-tags = true;
          multiword-tags = true;
        };

        # Need to specify the theme or else glow will not output color
        tool.fzf-preview = "${lib.getExe pkgs.glow} --style ${config.home.sessionVariables.GLAMOUR_STYLE} {-1}";

        lsp.diagnostics.dead-link = "error";
      };
    };
  };
}
