{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.my) mkHyprWorkspaces mkHyprMoveTo;
  inherit (lib.lists) elem optionals;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe getExe';
  inherit (config.my) desktop terminal browser;
  cfg = desktop.hyprland;
  num = desktop.general.workspace.number;
  mod = desktop.general.keybind.modifier;
  hyprsplit_enabled = cfg.plugins.enable && elem "hyprsplit" cfg.plugins.list;
  playerctl' = getExe pkgs.playerctl;
  wpctl' = getExe' pkgs.wireplumber "wpctl";
  brightnessctl' = getExe pkgs.brightnessctl;

  lang = "eng+chi_sim+chi_tra";
  wl-ocr = pkgs.writeShellScript "wl-ocr" ''
    ${getExe pkgs.grim} -g "$(${getExe pkgs.slurp})" - | ${getExe pkgs.tesseract} ${lang} - - | ${getExe' pkgs.wl-clipboard "wl-copy"}
  '';
  layouts = {
    qwerty = {
      left = "h";
      down = "j";
      up = "k";
      right = "l";
    };
    colemak = {
      left = "n";
      down = "e";
      up = "i";
      right = "o";
    };
  };
  layout = layouts.${config.my.keyboard.layout or "qwerty"};
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        "$mod" = mod;
        # keybindings
        bind =
          [
            # command
            "$mod SHIFT, Escape, exit,"
            "$mod, Q, killactive," # close the active window
            "$mod SHIFT, Q, forcekillactive," # kill the active windwo
            "$mod, B, exec, ${browser.exec}"
            "$mod, return, exec, ${terminal.exec}"

            # "$mod, space, exec, ags -t launcher"
            # "$mod SHIFT, R, exec, ags -q; ags"
            # "$mod, A, exec, ags -t overview"
            # "SUPER ALT, E,           exec, ags -r 'launcher.open(\":em \")'"
            # "SUPER ALT, V,           exec, ags -r 'launcher.open(\":ch \")'"
            # ",Print, exec, ags -r 'recorder.screenshot()'"
            # "$mod, Print, exec, ags -r 'recorder.screenshot(true)'"
            # "$mod ALT,Print, exec, ags -r 'recorder.start()'"
            # ",XF86PowerOff, exec, ags -t powermenu"
            # "$mod, U, exec, XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

            "$mod, J, togglesplit,"
            "$mod, Z, alterzorder, top"
            "$mod SHIFT, Z, alterzorder, bottom"
            "$mod SHIFT, F, togglefloating,"
            "$mod, F, fullscreen, 0"
            "$mod, M, fullscreen, 1"
            "$mod, P, pseudo,"
            "$mod SHIFT, P, pin,"
            # group
            "$mod, G, togglegroup,"
            "$mod SHIFT, G, changegroupactive, f"
            # move group
            "$mod SHIFT CONTROL, ${layout.left}, movewindoworgroUP, l"
            "$mod SHIFT CONTROL, ${layout.down}, movewindoworgroUP, d"
            "$mod SHIFT CONTROL, ${layout.up}, movewindoworgroUP, u"
            "$mod SHIFT CONTROL, ${layout.right}, movewindoworgroUP, r"
            # move focus
            "$mod, ${layout.left}, movefocus, l"
            "$mod, ${layout.down}, movefocus, d"
            "$mod, ${layout.up}, movefocus, u"
            "$mod, ${layout.right}, movefocus, r"
            # move window
            "$mod SHIFT, ${layout.left}, movewindow, l"
            "$mod SHIFT, ${layout.down}, movewindow, d"
            "$mod SHIFT, ${layout.up}, movewindow, u"
            "$mod SHIFT, ${layout.right}, movewindow, r"

            # special workspace
            "$mod SHIFT, grave, togglespecialworkspace"
            "$mod, grave, movetoworkspace, special"
            "$mod CTRL, grave, movetoworkspacesilent, special"
            # monitors
            "$mod, comma, focusmonitor, l"
            "$mod, period, focusmonitor, r"
            "$mod SHIFT, comma, movecurrentworkspacetomonitor, l"
            "$mod SHIFT, period, movecurrentworkspacetomonitor, r"
            # workspace
            "$mod, W, workspace, empty" # move to the first empty workspace
            # "$mod, tab, workspace, m+1"
            # "$mod SHIFT, tab, workspace, m-1"
            # send focused workspace to left/right monitor
            "$mod ALT, bracketleft, movecurrentworkspacetomonitor, l"
            "$mod ALT, bracketright, movecurrentworkspacetomonitor, r"
            # send focused workspace to left/right space silent
            "$mod CTRL, bracketleft, movetoworkspacesilent, -1"
            "$mod CTRL, bracketright, movetoworkspacesilent, +1"

            # Workspace control
            "$mod, D, focusworkspaceoncurrentmonitor, name:D" # desktop only
            "$mod, backspace, focusworkspaceoncurrentmonitor, previous"

            "$mod, mouse_down, focusworkspaceoncurrentmonitor, -1"
            "$mod, mouse_up, focusworkspaceoncurrentmonitor, +1"
            # utility
            # select area to perform OCR on
            "$mod, H, exec, ${wl-ocr}"
            ", XF86Favorites, exec, ${wl-ocr}"
          ]
          ++ (mkHyprMoveTo ["focusworkspaceoncurrentmonitor" "movetoworkspacesilent"] num)
          ++ (optionals (!hyprsplit_enabled)
            (mkHyprWorkspaces
              ["workspace" "movetoworkspace" "movetoworkspacesilent"]
              num))
          ++ (optionals (!cfg.switch.enable) [
            "ALT, tab, cyclenext,"
            "ALT SHIFT, tab, bringactivetotop,"
          ])
          ++ (optionals (!cfg.nome.enable) [
            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"
            "$mod, bracketleft, workspace, e+1"
            "$mod, bracketright, workspace, e-1"
            "$mod SHIFT, bracketleft, movetoworkspace, -1"
            "$mod SHIFT, bracketright, movetoworkspace, +1"
          ]);

        # Bind: mouse binds
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];

        # Bind: repeat while holding
        binde = [
          # Window split ratio
          "$mod, Minus, splitratio, -0.1"
          "$mod, Equal, splitratio, 0.1"
          "$mod, Semicolon, splitratio, -0.1"
          "$mod, Apostrophe, splitratio, 0.1"
          # resizing the active window
          "$mod CTRL, ${layout.left}, resizeactive, 10 0"
          "$mod CTRL, ${layout.down}, resizeactive, 0 10"
          "$mod CTRL, ${layout.up}, resizeactive, 0 -10"
          "$mod CTRL, ${layout.right}, resizeactive, -10 0"
        ];

        # Bind: locked binds
        bindl = [
          # media controls
          ", XF86AudioPlay, exec, ${playerctl'} play"
          ", XF86AudioPrev, exec, ${playerctl'} previous"
          ", XF86AudioNext, exec, ${playerctl'} next"
          ", XF86AudioPause, exec, ${playerctl'} pause"

          # volume
          ", XF86AudioMute, exec, ${wpctl'} set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, ${wpctl'} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # misc
          ", XF86Messenger, togglespecialworkspace"
        ];

        # Bind: locked and repeat
        bindel = [
          # volume
          ", XF86AudioRaiseVolume, exec, ${wpctl'} set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
          ", XF86AudioLowerVolume, exec, ${wpctl'} set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
          "ALT, XF86AudioRaiseVolume, exec, ${wpctl'} set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 6%+"
          "ALT, XF86AudioLowerVolume, exec, ${wpctl'} set-volume -l '1.0' @DEFAULT_AUDIO_SOURCE@ 6%-"

          # backlight
          ", XF86MonBrightnessUp, exec, ${brightnessctl'} --exponent s 5%+"
          ", XF86MonBrightnessDown, exec, ${brightnessctl'} --exponent s 5%-"
          ", XF86KbdBrightnessUp, exec, ${brightnessctl'} --device='*::kbd_backlight' s 10%+"
          ", XF86KbdBrightnessDown, exec, ${brightnessctl'} --device='*::kbd_backlight' s 10%-"
        ];
      };
      extraConfig = ''
        # window resize
        bind=$mod,R,submap,resize

        submap=resize
        binde=,${layout.left},resizeactive,10 0
        binde=,${layout.down},resizeactive,0 10
        binde=,${layout.up},resizeactive,0 -10
        binde=,${layout.right},resizeactive,-10 0

        binde=,right,resizeactive,10 0
        binde=,left,resizeactive,-10 0
        binde=,up,resizeactive,0 -10
        binde=,down,resizeactive,0 10


        binde=SHIFT,${layout.left},moveactive,-10 0
        binde=SHIFT,${layout.down},moveactive,0 10
        binde=SHIFT,${layout.up},moveactive,0 -10
        binde=SHIFT,${layout.right},moveactive,10 0

        binde=SHIFT,right,moveactive,10 0
        binde=SHIFT,left,moveactive,-10 0
        binde=SHIFT,up,moveactive,0 -10
        binde=SHIFT,down,moveactive,0 10

        bind = , SPACE, centerwindow

        bind = , escape, exec, hyprctl keyword input:follow_mouse 0
        bind=,escape,submap,reset
        submap=reset
      '';
    };
  };
}
