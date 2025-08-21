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
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.my) terminal;
  cfg = config.my.desktop.apps.ghostty;
in {
  options.my.desktop.apps.ghostty = {
    enable =
      mkEnableOption "ghostty"
      // {
        default = terminal.name == "ghostty";
      };
  };

  config = mkIf cfg.enable {
    xdg.configFile."ghostty/shadders".source =
      mkOutOfStoreSymlink (lib.my.relativeToConfig "ghostty/shaders");

    programs.ghostty = {
      enable = true;
      package =
        if isLinux
        then pkgs.ghostty
        else null;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        # font-family = terminal.font;
        # font-family-bold = terminal.font;
        # font-family-italic = terminal.font-italic;
        # font-family-bold-italic = terminal.font-italic;
        font-family = terminal.font;
        font-size = terminal.size;

        adjust-underline-position = 4;
        # Mouse
        mouse-hide-while-typing = true;
        # Theme
        cursor-invert-fg-bg = true;
        background-opacity = terminal.opacity;
        background-blur = true;
        window-theme = "ghostty";
        # window
        gtk-single-instance = true;
        gtk-tabs-location = "bottom";
        gtk-wide-tabs = false;
        window-padding-x = terminal.padding;
        window-padding-y = terminal.padding;
        window-padding-balance = true;
        window-decoration = false;
        # macos
        macos-titlebar-style = "hidden";
        macos-option-as-alt = true;
        macos-window-shadow = true;
        # shader
        custom-shader = "${inputs.ghostty-shaders}/bloom025.glsl";
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
          "ctrl+shift+equal=increase_font_size:1"
          "ctrl+shift+minus=decrease_font_size:1"
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
