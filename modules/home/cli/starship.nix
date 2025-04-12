{
  lib,
  config,
  ...
}: let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  os = icon: fg: "[${icon} ](fg:${fg})";
  cfg = config.my.starship;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
in {
  options.my.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableTransience = true;
      settings = {
        add_newline = true;
        format = builtins.concatStringsSep "" [
          "$os"
          "$directory"
          "$git_branch"
          "$git_status"
          "$nix_shell"
          "$direnv"
          "$conda"
          "$container"
          "$python"
          "$nodejs"
          "$lua"
          "$rust"
          "$java"
          "$c"
          "$golang"
          "$cmd_duration"
          "$status"
          "$line_break"
          "$character"
        ];
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[](bold red)";
          vicmd_symbol = "[](bold green)";
          vimcmd_replace_one_symbol = "[](bold magenta)";
          vimcmd_replace_symbol = "[](bold magenta)";
          vimcmd_visual_symbol = "[](bold yellow)";
        };
        continuation_prompt = "∙  ┆ ";
        line_break = {disabled = false;};
        # username = {
        #   style_user = "fg:peach bg:surface0";
        #   style_root = "fg:red bg:surface0";
        #   format = "[ $user]($style)";
        #   show_always = false;
        # };
        # hostname = {
        #   ssh_only = true;
        #   format = "[@$hostname](fg:green bg:surface0)";
        # };
        status = {
          symbol = "✗";
          success_symbol = " ";
          not_found_symbol = "󰍉 Not Found";
          not_executable_symbol = " Can't Execute E";
          sigint_symbol = "󰂭 ";
          signal_symbol = "󱑽 ";
          map_symbol = true;
          disabled = false;
        };
        cmd_duration = {
          min_time = 1000;
        };
        direnv = {
          disabled = false;
          symbol = " ";
        };
        nix_shell = {
          heuristic = true; # needed to detect `nix shell`
          symbol = "󱄅 "; # the default unicode is causing issue https://github.com/starship/starship/issues/5924
        };
        conda = {
          ignore_base = true;
        };
        container = {
          symbol = "󰏖 ";
        };
        directory = {
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
          read_only = " ";
          truncate_to_repo = true;
          truncation_length = 4;
          truncation_symbol = "";
          fish_style_pwd_dir_length = 1;
        };
        git_branch = {
          symbol = "";
        };
        git_status = {
          conflicted = " ";
          ahead = " ";
          behind = " ";
          diverged = "󰆗 ";
          up_to_date = " ";
          untracked = " ";
          stashed = " ";
          modified = " ";
          staged = " ";
          renamed = " ";
          deleted = " ";
        };
        os = {
          disabled = false;
          format = "$symbol";
          symbols = {
            Arch = os "" "blue";
            Alpine = os "" "blue";
            Debian = os "" "red";
            EndeavourOS = os "" "magenta";
            Fedora = os "" "blue";
            NixOS = os "" "blue";
            openSUSE = os "" "green";
            SUSE = os "" "green";
            Ubuntu = os "" "magenta";
            Macos = os "" "white";
          };
        };
        python = lang "" "yellow";
        nodejs = lang "󰛦" "blue";
        bun = lang "󰛦" "blue";
        deno = lang "󰛦" "blue";
        lua = lang "󰢱" "blue";
        rust = lang "" "red";
        java = lang "" "red";
        c = lang "" "blue";
        golang = lang "" "blue";
        dart = lang "" "blue";
        elixir = lang "" "magenta";
      };
    };
  };
}
