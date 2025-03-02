{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.fzf;
in {
  options.my.fzf = {enable = mkEnableOption "fzf" // {default = true;};};
  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--cycle"
        "--layout=reverse"
        "--height 60%"
        "--ansi"
        "--preview-window=right:70%"
        "--bind=ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-x:jump"
        "--bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up"
        "--bind=ctrl-a:beginning-of-line,ctrl-e:end-of-line"
        "--bind=ctrl-e:down,ctrl-i:up"
      ];
    };
  };
}
