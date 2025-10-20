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
          language = "en";
          default-title = "Untitled";
          template = "default.md";
          filename = "{{id}}-{{slug title}}";
          extension = "md";
          # The charset used for random IDs. You can use:
          #   * letters: only letters from a to z.
          #   * numbers: 0 to 9
          #   * alphanum: letters + numbers
          #   * hex: hexadecimal, from a to f and 0 to 9
          #   * custom string: will use any character from the provided value
          id-charset = "hex";

          # Length of the generated IDs.
          id-length = 6;
        };

        format.markdown = {
          link-format = "wiki";
          # Enable support for :colon:separated:tags:.
          hashtags = true;
          # Enable support for :colon:separated:tags:.
          colon-tags = true;
          # Enable support for Bear's #multi-word tags#
          multiword-tags = true;
        };
        group.daily = {
          # Directories listed here will automatically use this group when creating notes.
          paths = ["Notes/Journal"];

          note = {
            # %Y-%m-%d is actually the default format, so you could use {{format-date now}} instead.
            filename = "{{format-date now '%Y-%m-%d'}}";
            extension = "md";
            template = "daily.md";
          };
        };

        # Need to specify the theme or else glow will not output color
        tool = {
          inherit (config.my) editor shell pager;
          fzf-preview = "${lib.getExe pkgs.glow} --style ${config.home.sessionVariables.GLAMOUR_STYLE} {-1}";
        };

        lsp.diagnostics.dead-link = "error";

        alias = {
          list = "zk list --quiet -f oneline $@";
          ls = "zk list $@";
          wc = "zk list --sort word-count $@";

          search = "zk list -i $@";

          # Edit the last modified note.
          editlast = "zk edit --limit 1 --sort modified- $@";

          # Edit the notes selected interactively among the notes created the last two weeks.
          # This alias doesn't take any argument, so we don't use $@.
          recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";

          # Print paths separated with colons for the notes found with the given
          # arguments. This can be useful to expand a complex search query into a flag
          # taking only paths. For example:
          #   zk list --link-to "`zk path -m potato`"
          path = "zk list --quiet --format {{path}} --delimiter , $@";

          # Returns the Git history for the notes found with the given arguments.
          # Note the use of a pipe and the location of $@.
          hist = "zk list --format path --delimiter0 --quiet $@ | xargs -t -0 git log --patch --";

          tags = "zk tag list $@";
        };
        extra.author = config.my.name;
      };
    };
  };
}
