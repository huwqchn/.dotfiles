{
  lib,
  pkgs,
  config,
  ...
}: {
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
}
