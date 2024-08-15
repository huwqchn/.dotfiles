{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";

      lowopacity = [
        "bar"
        "calendar"
        "notifications"
        "system-menu"
      ];

      highopacity = [
        "anyrun"
        "osd"
        "logout_dialog"
      ];

      blurred = lib.concatLists [
        lowopacity
        highopacity
      ];
    in [
      "blur, ${toRegex blurred}"
      "xray 1, ${toRegex ["bar"]}"
      "ignorealpha 0.5, ${toRegex (highopacity ++ ["music"])}"
      "ignorealpha 0.2, ${toRegex lowopacity}"
    ];

    windowrule = [
      "float, confirm"
      "float, file_progress"
      "float, dialog"
      "float, pavucontrol"
      "float, nm-connection-editor"
      "float, blueman-manager"
      "size 40% 40%, blueman-manager"
      "move 59% 30, blueman-manager"
      "float, blueman-manager"
      "float, cpupower-gui"
      "fullscreen, wlogout"
      "float, title:wlogout"
      "fullscreen, title:wlogout"
    ];

    windowrulev2 = [
      # 1Password
      "float, title:^(1Password)$"

      # allow tearing in games
      "immediate, class:^(osu\!|cs2)$"
      # start spotify in ws9
      "workspace 9 silent, title:^(Spotify( Premium)?)$"

      # make Firefox PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

      # opacity rules
      "opacity 0.80 0.80,class:^(kitty)$"
      "opacity 0.70 0.70,class:^(Spotify)$"
    ];

  };

}
