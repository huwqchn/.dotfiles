{
  config,
  lib,
  ...
}: let
  cfg = config.my.atuin;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (config.home) homeDirectory;
in {
  options.my.atuin = {
    enable = mkEnableOption "atuin";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
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
        key_path = config.age.secrets.atuin-key.path;
      };
    };

    home.persistence."/persist${homeDirectory}".directories = [
      ".local/share/atuin"
    ];

    age.secrets.atuin-key.rekeyFile = ./secrets/atuin-key.age;
  };
}
