{
  lib,
  config,
  pkgs,
  ...
}: let
  # workspaces
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        "$mod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);

  toggle = program: service: let
    prog = builtins.substring 0 14 program;
    runserv = lib.optionalString service "run-as-service";
  in "pkill ${prog} || ${runserv} ${program}";

  runOnce = program: "pgrep ${program} || ${program}";
  cfg = config.my.desktop.wayland;
  inherit (lib) mkIf;
in {
  config = mkIf (cfg.enable && pkgs.stdenv.isLinux) {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$browser" = "zen";
      "$terminal" = "wezterm";
      # keybindings
      bind =
        [
          # command
          "$mod SHIFT, Escape, exit,"
          "$mod, Backspace, exec, ${toggle "wlogout" true} -p layer-shell"
          "$mod, Q, killactive,"
          "$mod, L, exec, ${runOnce "hyprlock"}"
          "$mod, B, exec, $browser"
          "$mod, return, exec, $terminal"
          "$mod, space, exec, ags -t launcher"
          "$mod SHIFT, R, exec, ags -q; ags"
          "$mod, A, exec, ags -t overview"
          # "SUPER ALT, E,           exec, ags -r 'launcher.open(\":em \")'"
          # "SUPER ALT, V,           exec, ags -r 'launcher.open(\":ch \")'"
          ",Print, exec, ags -r 'recorder.screenshot()'"
          "$mod, Print, exec, ags -r 'recorder.screenshot(true)'"
          "$mod ALT,Print, exec, ags -r 'recorder.start()'"
          ",XF86PowerOff, exec, ags -t powermenu"
          "$mod, U, exec, XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

          "$mod, T, togglefloating,"
          "$mod SHIFT, T, pseudo,"
          "$mod, J, togglesplit,"
          "$mod, F, fullscreen, 0"
          "$mod, M, fullscreen, 1"
          "$mod, G, togglegroup,"
          "$mod, P, pin,"
          # move focus
          "$mod, N, movefocus, l"
          "$mod, E, movefocus, d"
          "$mod, I, movefocus, u"
          "$mod, O, movefocus, r"
          # move window
          "$mod SHIFT, N, movewindow, l"
          "$mod SHIFT, E, movewindow, d"
          "$mod SHIFT, I, movewindow, u"
          "$mod SHIFT, O, movewindow, r"
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
          "$mod, tab, workspace, m+1"
          "$mod SHIFT, tab, workspace, m-1"
          "ALT, tab, cyclenext,"
          "ALT SHIFT, tab, bringactivetotop,"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, bracketleft, workspace, e+1"
          "$mod, bracketright, workspace, e-1"
          "$mod SHIFT, bracketleft, movetoworkspace, -1"
          "$mod SHIFT, bracketright, movetoworkspace, +1"
          # send focused workspace to left/right monitor
          "$mod ALT, bracketleft, movecurrentworkspacetomonitor, l"
          "$mod ALT, bracketright, movecurrentworkspacetomonitor, r"
          # send focused workspace to left/right space silent
          "$mod CTRL, bracketleft, movetoworkspacesilent, -1"
          "$mod CTRL, bracketright, movetoworkspacesilent, +1"
        ]
        ++ workspaces;

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "SUPER, mouse:272, movewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];

      binde = [
        # Window split ratio
        "$mod, Minus, splitratio, -0.1"
        "$mod, Equal, splitratio, 0.1"
        "$mod, Semicolon, splitratio, -0.1"
        "$mod, Apostrophe, splitratio, 0.1"
        # resizing the active window
        "$mod CTRL, N, resizeactive, 10 0"
        "$mod CTRL, E, resizeactive, 0 10"
        "$mod CTRL, I, resizeactive, 0 -10"
        "$mod CTRL, O, resizeactive, -10 0"
      ];

      bindl = [
        # media controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        # volume
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindel = [
        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

        # backlight
        ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
        ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
      ];
    };
    wayland.windowManager.hyprland.extraConfig = ''
      # window resize
      bind=$mod,R,submap,resize

      submap=resize
      binde=,N,resizeactive,10 0
      binde=,E,resizeactive,0 10
      binde=,I,resizeactive,0 -10
      binde=,O,resizeactive,-10 0
      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10
      bind=,escape,submap,reset
      submap=reset
    '';
  };
}
