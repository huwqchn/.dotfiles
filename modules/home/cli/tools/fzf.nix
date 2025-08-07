{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.my.fzf;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  find' = "${getExe pkgs.fd} --type=f --hidden --exclude=.git";
in {
  options.my.fzf = {
    enable = mkEnableOption "fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultCommand = find';
      defaultOptions =
        [
          "--cycle"
          "--layout=reverse"
          "--height 60%"
          "--ansi"
          "--preview-window=right:70%"
          "--bind=ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-x:jump"
          "--bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up"
          "--bind=ctrl-a:beginning-of-line,ctrl-e:end-of-line"
          "--prompt=''"
          "--pointer=''"
          "--marker='│'"
          "--separator='─'"
          "--scrollbar = '│'"
        ]
        ++ (
          if (config.my.keyboardLayout == "colemak")
          then [
            "--bind=ctrl-e:down,ctrl-i:up"
          ]
          else [
            "--bind=ctrl-j:down,ctrl-k:up"
          ]
        );
      fileWidgetCommand = find';
      fileWidgetOptions = ["--preview 'head {}'"];

      changeDirWidgetCommand = "${getExe pkgs.fd} --type=d --hidden --exclude=.git";

      changeDirWidgetOptions = [
        "--preview 'tree -C {} | head -200'"
      ];
    };
  };
}
