{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf types mkOption;
  cfg = config.my.ripgrep;
in {
  options.my.ripgrep = {
    enable = mkOption {
      default = true;
      type = types.bool;
      description = "Enable ripgrep";
    };
  };
  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [
        # Don't let ripgrep vomit really long lines to my terminal, and show a preview.
        "--max-columns=150"
        "--max-columns-preview"

        # Add my 'web' type.
        "--type-add"
        "web:*.{html,css,js}*"

        # Search hidden files / directories (e.g. dotfiles) by default
        "--hidden"

        # Using glob patterns to include/exclude files or folders
        "--glob=!.git/*"

        # or
        "--glob"
        "!.git/*"

        # Set the colors.
        "--colors=line:none"
        "--colors=line:style:bold"

        # Because who cares about case!?
        "--smart-case"
      ];
    };
  };
}
