{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  src = pkgs.vimPlugins.tokyonight-nvim;
  inherit (config.my.theme.colorscheme) slug;
  enable = cfg.enable && config.my.zellij.enable;
  inherit (config.my.theme) tokyonight colorscheme;
  inherit (colorscheme) palette;
  cfg = tokyonight;
  zjstatusWasm = "${pkgs.zjstatus}/bin/zjstatus.wasm";
in {
  config = mkIf enable {
    programs.zellij = {
      settings = {
        theme = slug;
        theme_dir = "${src}/extras/zellij";
      };
      layouts = {
        default = {
          layout = {
            _children = [
              {
                default_tab_template = {
                  _children = [
                    {
                      pane = {
                        size = 1;
                        borderless = true;
                        plugin = {
                          _props.location = "file:${zjstatusWasm}";
                          _children = with palette; [
                            {
                              # source: https://github.com/merikan/.dotfiles/blob/main/config/zellij/themes/zjstatus/catppuccin.kdl

                              format_left = "#[bg=${bg_statusline},fg=${bright_blue}]#[bg=${bright_blue},fg=${fg_dark},bold] {session} #[bg=${bg_statusline}] {mode}#[bg=${bg_statusline}] {tabs}";
                              format_center = "{notifications}";
                              format_right = "#[bg=${bg_statusline},fg=${orange}]#[fg=${fg_dark},bg=${orange}] #[bg=${bg_highlight},fg=${orange},bold] {command_user}@{command_host}#[bg=${bg_statusline},fg=${bg_highlight}]#[bg=${bg_statusline},fg=${info}]#[bg=${info},fg=${fg_dark}]󰃭 #[bg=${bg_highlight},fg=${info},bold] {datetime}#[bg=${bg_highlight},fg=${bg_statusline}]";
                              format_space = "#[bg=${bg_statusline}]";
                              format_hide_on_overlength = "true";
                              format_precedence = "lrc";

                              border_enabled = "false";
                              border_char = "─";
                              border_format = "#[bg=${bg_highlight}]{char}";
                              border_position = "top";

                              hide_frame_for_single_pane = "false";

                              mode_normal = "#[bg=${green},fg=${fg_dark},bold]NORMAL#[bg=${bg_statusline},fg=${green}]";
                              mode_tmux = "#[bg=${blue},fg=${fg_dark},bold]TMUX#[bg=${bg_statusline},fg=${blue}]";
                              mode_locked = "#[bg=${red},fg=${fg_dark},bold]LOCKED#[bg=${bg_statusline},fg=${red}]";
                              mode_pane = "#[bg=${green2},fg=${fg_dark},bold]PANE#[bg=${bg_statusline},fg=${green2}]";
                              mode_tab = "#[bg=${teal},fg=${fg_dark},bold]TAB#[bg=${bg_statusline},fg=${teal}]";
                              mode_scroll = "#[bg=${orange},fg=${fg_dark},bold]SCROLL#[bg=${bg_highlight},fg=${orange}]";
                              mode_enter_search = "#[bg=${orange},fg=${fg_dark},bold]ENT-SEARCH#[bg=${bg_statusline},fg=${orange}]";
                              mode_search = "#[bg=${orange},fg=${fg_dark},bold]SEARCHARCH#[bg=${bg_statusline},fg=${orange}]";
                              mode_resize = "#[bg=${yellow},fg=${fg_dark},bold]RESIZE#[bg=${bg_highlight},fg=${yellow}]";
                              mode_rename_tab = "#[bg=${yellow},fg=${fg_dark},bold]RENAME-TAB#[bg=${bg_statusline},fg=${yellow}]";
                              mode_rename_pane = "#[bg=${yellow},fg=${fg_dark},bold]RENAME-PANE#[bg=${bg_statusline},fg=${yellow}]";
                              mode_move = "#[bg=${yellow},fg=${fg_dark},bold]MOVE#[bg=${bg_statusline},fg=${yellow}]";
                              mode_session = "#[bg=${magenta2},fg=${fg_dark},bold]SESSION#[bg=${bg_statusline},fg=${magenta2}]";
                              mode_prompt = "#[bg=${magenta2},fg=${fg_dark},bold]PROMPT#[bg=${bg_statusline},fg=${magenta2}]";

                              tab_normal = "#[fg=${blue}]#[bg=${blue},fg=${fg_dark},bold]{index} #[bg=${bg_highlight},fg=${blue},bold] {name}{floating_indicator}#[fg=${bg_highlight}]";
                              tab_normal_fullscreen = "#[fg=${blue}]#[bg=${blue},fg=${fg_dark},bold]{index} #[bg=${bg_highlight},fg=${blue},bold] {name}{fullscreen_indicator}#[fg=${bg_highlight}]";
                              tab_normal_sync = "#[fg=${blue}]#[bg=${blue},fg=${fg_dark},bold]{index} #[bg=${bg_highlight},fg=${blue},bold] {name}{sync_indicator}#[fg=${bg_highlight}]";
                              tab_active = "#[fg=${purple}]#[bg=${purple},fg=${fg_dark},bold]{index} #[bg=${bg_highlight},fg=${purple},bold] {name}{floating_indicator}#[fg=${bg_highlight}]";
                              tab_active_fullscreen = "#[fg=${purple}]#[bg=${purple},fg=${fg_dark},bold]{index} #[bg=${bg_highlight},fg=${purple},bold] {name}{fullscreen_indicator}#[fg=${bg_highlight}]";
                              tab_active_sync = "#[fg=${purple}]#[bg=${purple},fg=${fg_dark},bold]{index} #[bg=${bg_highlight},fg=${purple},bold] {name}{sync_indicator}#[fg=${bg_highlight}]";
                              tab_separator = " ";

                              tab_sync_indicator = " ";
                              tab_fullscreen_indicator = " 󰊓";
                              tab_floating_indicator = " 󰹙";

                              notification_format_unread = "#[bg={bg_highlight},fg=${yellow}]#[bg=${yellow},fg=${fg_dark}] #[bg=${bg_highlight},fg=${yellow}] {message}#[fg=${yellow}]";
                              notification_format_no_notifications = "";
                              notification_show_interval = "10";

                              command_host_command = "uname -n";
                              command_host_format = "{stdout}";
                              command_host_interval = "0";
                              command_host_rendermode = "static";

                              command_user_command = "whoami";
                              command_user_format = "{stdout}";
                              command_user_interval = "10";
                              command_user_rendermode = "static";

                              datetime = "{format}";
                              datetime_format = "%Y-%m-%d 󰅐 %I:%M %p";
                              datetime_timezone = "Asia/Kolkata";
                            }
                          ];
                        };
                      };
                    }
                    {
                      "children" = {};
                    }
                  ];
                };
              }
            ];
          };
        };
      };
    };
  };
}
