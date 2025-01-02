{ ghostty, ... }:
{
  imports = [
    ghostty.homeModules.default
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      # fonts
      font-size = 10;
      font-family = "Fira Code";
      font-family-bold = "Fira Code";
      font-family-italic = "Maple Mono";
      font-family-bold-italic = "Maple Mono";
      adjust-underline-position = 4;
      
      # mouse
      mouse-hide-while-typing = true;
      cursor-invert-fg-bg = true;
      background-opacity = 0.85;
      background-blur-radius = 20;
      whindow-theme = "ghostty"; 

      # Window
      gtk-single-instance = true;
      gtk-tabs-location = "bottom";
      git-wide-tabs = false;
      gtk-titlebar = false; # better on tiling wm
      window-padding-y = "2,0";
      window-padding-balance = true;
      window-decoration = false;

      # keybindings
      clearDefaultKeybindgins = true;

      keybindings = 
      ''
        {
          "ctrl+n" = "goto_split:left";
          "ctrl+e" = "goto_split:down";
          "ctrl+i" = "goto_split:up";
          "ctrl+o" = "goto_split:right";
          "ctrl+shift+enter" = "new_split:auto";
          "ctrl+shift+m" = "toggle_split_zoom";
          "ctrl+shift+r" = "reload_config";
          "ctrl+shift+w" = "close_surface";
          "ctrl+shift+i" = "inspector:toggle";
          "ctrl+shift+s" = "write_screen_file:open";
          "ctrl+shift+t" = "new_tab";
        }
      '';
     
      # other
      copy-on-select = "clipboard";
      shell-integration-features = "cursor,sudo,no-title";
    };
  };
}