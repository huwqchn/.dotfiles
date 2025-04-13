{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (inputs) ghostty-shaders;
  inherit (config.my.themes) opacity;
  cfg = config.my.desktop.apps.ghostty;
in {
  options.my.desktop.apps.ghostty = {
    enable =
      mkEnableOption "ghostty"
      // {
        default = config.my.terminal == "ghostty";
      };
  };

  config = mkIf cfg.enable {
    xdg.configFile."ghostty/shadders".source =
      mkOutOfStoreSymlink (lib.my.relativeToConfig "ghostty/shaders");
    programs.ghostty = {
      enable = true;
      package =
        if pkgs.stdenv.isLinux
        then pkgs.ghostty
        else null;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      # themes = {
      #   tokyonight-moon = {
      #     palette = [
      #       "0=#1b1d2b"
      #       "1=#ff757f"
      #       "2=#c3e88d"
      #       "3=#ffc777"
      #       "4=#82aaff"
      #       "5=#c099ff"
      #       "6=#86e1fc"
      #       "7=#828bb8"
      #       "8=#444a73"
      #       "9=#ff8d94"
      #       "10=#c7fb6d"
      #       "11=#ffd8ab"
      #       "12=#9ab8ff"
      #       "13=#caabff"
      #       "14=#b2ebff"
      #       "15=#c8d3f5"
      #     ];
      #     background = "#222436";
      #     foreground = "#c8d3f5";
      #     cursor-color = "#c8d3f5";
      #     selection-background = "#2d3f76";
      #     selection-foreground = "#c8d3f5";
      #   };
      # };
      settings = {
        font-family = "JetBrainsMono Nerd Font Mono";
        font-family-bold = "JetBrainsMono Nerd Font Mono";
        font-family-italic = "Maple Mono";
        font-family-bold-italic = "Maple Mono";
        font-size = 13;
        adjust-underline-position = 4;
        # Mouse
        mouse-hide-while-typing = true;
        # Theme
        # theme = "light:tokyonight-moon,dark:tokyonight-moon";
        cursor-invert-fg-bg = true;
        background-opacity = opacity;
        background-blur = true;
        window-theme = "ghostty";
        # window
        gtk-single-instance = true;
        gtk-tabs-location = "bottom";
        gtk-wide-tabs = false;
        window-padding-y = "2,0";
        window-padding-balance = true;
        window-decoration = false;
        # macos
        macos-titlebar-style = "hidden";
        macos-option-as-alt = true;
        macos-window-shadow = true;
        # shader
        custom-shader = "${ghostty-shaders}/shaders/bloom025.glsl";
        # other
        copy-on-select = "clipboard";
        shell-integration-features = "cursor,sudo,no-title";
        quit-after-last-window-closed = true;
        confirm-close-surface = false;
        # keybinds
        keybind = [
          "clear"
          "ctrl+shift+n=goto_split:left"
          "ctrl+shift+e=goto_split:bottom"
          "ctrl+shift+i=goto_split:top"
          "ctrl+shift+o=goto_split:right"
          "ctrl+shift+t=new_tab"
          "ctrl+shift+left_bracket=previous_tab"
          "ctrl+shift+right_bracket=next_tab"
          "ctrl+shift+comma=move_tab:-1"
          "ctrl+shift+period=move_tab:1"
          "ctrl+shift+minus=increase_font_size:1"
          "ctrl+shift+equal=decrease_font_size:1"
          "ctrl+shift+kp_0=reset_font_size"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+shift+enter=new_split:auto"
          "ctrl+shift+i=inspector:toggle"
          "ctrl+shift+m=toggle_split_zoom"
          "ctrl+shift+r=reload_config"
          "ctrl+shift+s=write_screen_file:open"
          "ctrl+shift+w=close_surface"
        ];
      };
    };
  };
}
