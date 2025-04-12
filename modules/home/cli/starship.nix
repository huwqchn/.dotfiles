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
  pad = {
    left = "";
    right = "";
  };
  cfg = config.my.starship;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (builtins) concatStringsSep;
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
          "$container"
          "$git_branch $git_status"
          "$python"
          "$nodejs"
          "$lua"
          "$rust"
          "$java"
          "$c"
          "$golang"
          "$nix_shell"
          "$cmd_duration"
          "$status"
          "$line_break"
          "$character"
        ];
        character = {
          success_symbol = "[❯](green bold)";
          error_symbol = "[](red bold)";
          vicmd_symbol = "[](green)";
          vimcmd_replace_one_symbol = "[](yellow)";
          vimcmd_replace_symbol = "[](yellow bold)";
          vimcmd_visual_symbol = "[](purple)";
        };
        continuation_prompt = "∙  ┆ ";
        line_break = {disabled = false;};
        username = {
          style_user = "fg:peach bg:surface0";
          style_root = "fg:red bg:surface0";
          format = "[ $user]($style)";
          show_always = false;
        };
        hostname = {
          ssh_only = true;
          format = "[@$hostname](fg:green bg:surface0)";
        };
        status = {
          symbol = "✗";
          success_symbol = " ";
          not_found_symbol = "󰍉 Not Found";
          not_executable_symbol = " Can't Execute E";
          sigint_symbol = "󰂭 ";
          signal_symbol = "󱑽 ";
          format = "[$symbol](fg:red)";
          map_symbol = true;
          disabled = false;
        };
        cmd_duration = {
          min_time = 1000;
          format = "[$duration ](fg:yellow)";
        };
        direnv = {
          disabled = false;
          format = "[$symbol\\($loaded/$allowed\\) ](fg:blue)";
          symbol = "  ";
        };
        nix_shell = {
          format = "[$symbol(\\($name\\)) ](fg:blue)";
          heuristic = true; # needed to detect `nix shell`
          symbol = "󱄅 "; # the default unicode is causing issue https://github.com/starship/starship/issues/5924
        };
        container = {
          symbol = " 󰏖";
          format = "[$symbol ](yellow dimmed)";
        };
        directory = {
          format = concatStringsSep "" [
            " [${pad.left}](fg:bright-black)"
            "[$path](bg:bright-black fg:white)"
            "[${pad.right}](fg:bright-black)"
            " [$read_only](fg:yellow)"
          ];
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
          style = "";
          format = "[ $symbol $branch](fg:purple)(:$remote_branch)";
        };
        git_status = {
          format = "[$all_status$ahead_behind]($style)";
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
            Arch = os "" "bright-blue";
            Alpine = os "" "bright-blue";
            Debian = os "" "red)";
            EndeavourOS = os "" "purple";
            Fedora = os "" "blue";
            NixOS = os "" "blue";
            openSUSE = os "" "green";
            SUSE = os "" "green";
            Ubuntu = os "" "bright-purple";
            Macos = os "" "white";
          };
        };
        python = lang "" "yellow";
        nodejs = lang "󰛦" "bright-blue";
        bun = lang "󰛦" "blue";
        deno = lang "󰛦" "blue";
        lua = lang "󰢱" "blue";
        rust = lang "" "red";
        java = lang "" "red";
        c = lang "" "blue";
        golang = lang "" "blue";
        dart = lang "" "blue";
        elixir = lang "" "purple";
      };
    };
  };
}
