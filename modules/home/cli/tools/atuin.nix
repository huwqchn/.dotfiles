{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.atuin;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.meta) getExe getExe';
  inherit (config.home) homeDirectory;
  inherit (pkgs.stdenv) isLinux isDarwin;
  atuin' = getExe pkgs.atuin;
  cat' = getExe' pkgs.coreutils "cat";
  atuinAutoLoginScript = pkgs.writeShellScript "atuin-auto-login.sh" ''
    if [ -e ${config.home.homeDirectory}/.local/share/atuin/session ]; then
      echo "atuin session exists already"
    else
      echo "Logging into atuin"
      ${atuin'} login \
        -u "$(${cat'} ${config.sops.secrets.atuin_name.path})" \
        -p "$(${cat'} ${config.sops.secrets.atuin_password.path})" \
        -k "$(${cat'} ${config.sops.secrets.atuin_keys.path})"
    fi
  '';
in {
  options.my.atuin = {
    enable = mkEnableOption "atuin";
    autoLogin = mkEnableOption "atuin auto login";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.atuin = {
        enable = true;
        # Enable the background daemon
        # Add the new section to the bottom of your config file
        daemon.enable = true;
        flags = ["--disable-up-arrow"];
        settings = {
          ## enable or disable automatic sync
          auto_sync = true;

          ## address of the sync server
          sync_address = "https://api.atuin.sh";

          ## how often to sync history. note that this is only triggered when a command
          ## is ran, so sync intervals may well be longer
          ## set it to 0 to sync after every command
          sync_frequency = "1h";

          ## which search mode to use
          ## possible values: prefix, fulltext, fuzzy, skim
          search_mode = "fuzzy";

          ## which style to use
          ## possible values: auto, full, compact
          style = "compact";

          ## the maximum number of lines the interface should take up
          ## set it to 0 to always go full screen
          inline_height = 20;

          ## enable or disable showing a preview of the selected command
          ## useful when the command is longer than the terminal width and is cut off
          show_preview = true;

          ## possible values: emacs, subl
          word_jump_mode = "emacs";

          ## my atuin secret key
          key_path = config.sops.secrets.atuin_key.path;
        };
      };
      sops.secrets = {
        atuin_key = {};
        atuin_name = {};
        atuin_password = {};
        atuin_keys = {};
      };
    }
    (mkIf isDarwin {
      launchd.agents.atuin-auto-login = mkIf cfg.autoLogin {
        enable = true;
        config = {
          ProgramArguments = ["${atuinAutoLoginScript}"];
          RunAtLoad = true;
          KeepAlive = false;
          Requires = [
            "org.nix-community.home.sops-nix"
            "org.nix-community.home.atuin-daemon"
          ];
          ProcessType = "Background";
        };
      };
    })
    (mkIf isLinux {
      home.persistence."/persist${homeDirectory}".directories = [
        ".local/share/atuin"
      ];
      systemd.user.services.atuin-auto-login = mkIf cfg.autoLogin {
        Unit = {
          Description = "automatic atuin login";
          Requires = ["sops-nix.service" "atuin-daemon.service"];
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${atuinAutoLoginScript}";
          Restart = "on-failure";
        };

        Install = {
          WantedBy = ["default.target"];
        };
      };
    })
  ]);
}
