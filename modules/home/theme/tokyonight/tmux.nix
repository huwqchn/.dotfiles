{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my.theme) tokyonight colorscheme;
  inherit (config.my.theme.general) transparent pad;
  inherit (colorscheme) palette;
  cfg = tokyonight;
in {
  config = mkIf cfg.enable {
    programs.tmux.plugins = with pkgs.tmuxPlugins; let
      status_bg =
        if transparent
        then "bg=default"
        else "bg=$color_background";
      pad_style = fg: "#[fg=${fg},${status_bg}]";
      gray_pad_style = pad_style "$color_gray";
      blue_pad_style = pad_style "$color_blue";
      left_pad = "${gray_pad_style}${pad.left}";
      right_pad = "${gray_pad_style}${pad.right}";
      current_left_pad = "${blue_pad_style}${pad.left}";
      current_right_pad = "${blue_pad_style}${pad.right}";
    in [
      {
        plugin = mode-indicator;
        extraConfig = with palette; ''
          #################################### PLUGINS ###################################

          set -g @mode_indicator_prefix_prompt " WAIT"
          set -g @mode_indicator_prefix_mode_style fg=$color_yellow,bg=$color_gray,bold
          set -g @mode_indicator_copy_prompt " COPY"
          set -g @mode_indicator_copy_mode_style fg=$color_green,bg=$color_gray,bold
          set -g @mode_indicator_sync_prompt " SYNC"
          set -g @mode_indicator_sync_mode_style fg=$color_red,bg=$color_gray,bold
          set -g @mode_indicator_empty_prompt " TMUX"
          set -g @mode_indicator_empty_mode_style fg=$color_blue,bg=$color_gray,bold

          #################################### OPTIONS ###################################
          color_background='${bg}'
          color_foreground='${fg}'
          color_gray='${bg_highlight}'
          color_red='${red}'
          color_yellow='${orange}'
          color_green='${green}'
          color_blue='${blue}'
          color_cyan='${cyan}'

          set -g status on
          set -g status-justify centre
          set -g status-position top
          set -g status-left-length 90
          set -g status-right-length 90
          set -g status-style ${status_bg}
          setw -g window-status-separator " "

          # set -g window-style ""
          # set -g window-active-style ""

          # Note: default window-status-activity-style is 'reverse'
          setw -g window-status-activity-style none
          setw -g window-status-bell-style none

          set -g message-style bg=$color_blue,fg=$color_background
          set -g message-command-style bg=$color_background,fg=$color_foreground
          set-window-option -g mode-style bg=$color_gray,fg=$color_green

          set -g pane-border-style fg=$color_background
          set -g pane-active-border-style fg=$color_blue

          ##################################### FORMAT ###################################
          set -g status-left "${left_pad}#{tmux_mode_indicator}${right_pad}"
          set -g status-right "${left_pad}#[fg=$color_cyan,bg=$color_gray] #S${right_pad} ${left_pad}#[fg=$color_foreground,bg=$color_gray] %H:%M${right_pad}"
          setw -g window-status-format "${left_pad}#{?window_activity_flag,#[fg=$color_yellow],#[fg=$color_foreground]}#[bg=$color_gray,italics]#I: #[noitalics]#W#{?window_last_flag,  ,}#{?window_activity_flag,  ,}#{?window_bell_flag, #[fg=$color_red]󰂞 ,}${right_pad}"
          setw -g window-status-current-format "${current_left_pad}#[fg=$color_background,bg=$color_blue,italics]#I: #[bg=$color_blue,noitalics,bold]#{?window_zoomed_flag,[#W],#W}${current_right_pad}"
        '';
      }
    ];
  };
}
