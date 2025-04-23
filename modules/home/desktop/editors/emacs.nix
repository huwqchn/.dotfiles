{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.emacs;
in {
  options.my.emacs = {
    enable =
      mkEnableOption "Enable Emacs"
      // {
        default = true;
      };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        binutils # native-comp needs 'as', provided by this

        sqlite # for org-roam
        emacs-all-the-icons-fonts
      ];
      sessionPath = ["${config.xdg.configHome}/emacs/bin"];
      sessionVariables.EDITOR = "emacsclient -t";
    };

    services.emacs = {
      enable = true;
      # generate emacsclient desktop file
      client.enable = true;
      socketActivation.enable = true;
    };

    programs.emacs = {
      enable = true;
    };
  };
}
