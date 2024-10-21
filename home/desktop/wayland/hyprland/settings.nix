{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "CLUTTER_BACKEND,wayland"
      "GDK_BACKEND,wayland,x11"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,qt6ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "MOZ_ENABLE_WAYLAND,1"
      "GDK_SCALE,1"
      "GDK_DPI_SCALE,1"
      "SDL_VIDEODRIVER,wayland"
      "WLR_NO_HARDWARE_CURSORS,1"
      "SDL_VIDEODRIVER,wayland"
      # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      # fix https://github.com/hyprwm/Hyprland/issues/1520
      "WLR_NO_HARDWARE_CURSORS,1"
    ];

    exec = [
      # "gsettings set ${gnome-schema} gtk-theme $system_theme"
      # "gsettings set ${gnome-schema} icon-theme $icon_theme"
      # "gsettings set ${gnome-schema} cursor-theme $cursor_theme"
      "gsettings set org.gnome.desktop.interface text-scaling-factor $text_scale"
      "gsettings set org.gnome.desktop.interface cursor-size $cursor_size"
      "hyprshade auto"
    ];

    exec-once = [
      "systemctl --user import-environment"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XAUTHORITY"
      "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
      "gnome-keyring-daemon --start"
      "ags"
      "easyeffects --gapplication-service"
      # "safeeyes -e"
      "wl-clip-persist --clipboard regular"
      "wl-paste --watch cliphist store"
      "xhost si:localuser:root"
      "hyprlock"
    ];

    input = {
      kb_layout = "us";
      kb_options = "ctrl:nocaps";
      # focus change on cursor move
      follow_mouse = 1;
      accel_profile = "flat";
      repeat_rate = 25;
      repeat_delay = 200;

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.2;
      };
    };

    general = {
      allow_tearing = true;
      gaps_in = 10;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "0xff5e81ac";
      "col.inactive_border" = "0x66333333";
      layout = "dwindle";
    };

    group = {
      "col.border_active" = lib.mkForce "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
      "col.border_inactive" = lib.mkForce "rgba(b4befecc) rgba(6c7086cc) 45deg";
      "col.border_locked_active" = lib.mkForce "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
      "col.border_locked_inactive" = lib.mkForce "rgba(b4befecc) rgba(6c7086cc) 45deg";
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      force_default_wallpaper = 0;
      enable_swallow = false;
      swallow_regex = "^(org\.wezfurlong\.wezterm)$";
      # disable dragging animation
      animate_mouse_windowdragging = false;
      # enable variable refresh rate (effective depending on hardware)
      vrr = true;
    };

    master = {
      no_gaps_when_only = true;
    };

    decoration = {
      rounding = 19;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.01;

        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        size = 13;
        passes = 3; # more passes = more resource intensive
        new_optimizations = true;

        popups = true;
        popups_ignorealpha = 0.2;
      };

      drop_shadow = true;
      # shadow_ignore_window = true;
      # shadow_offset = "2 2";
      shadow_range = 30;
      shadow_render_power = 3;
      # shadow_scale = 0.97;
      "col.shadow" = "0xffa7caff";
      "col.shadow_inactive" = "0x50000000";
    };

    animations = {
      enabled = true;
      bezier = [
        "overshot,0.13,0.99,0.29,1.1"
        "linear,0,0,1,1"
        # "smoothOut, 0.36, 0, 0.66, -0.56"
        # "smoothIn, 0.25, 1, 0.5, 1"
        # "snappy, 0.5, 0.93, 0, 1"
      ];
      animation = [
        "windows,1,4,overshot,slide"
        "fade,1,10,default"
        "workspaces,1,8.8,overshot,slide"
        # "border,1,14,default"
        "border,1,5,linear"
        "borderangle,1,360,linear,loop"
        # "windows, 1, 5, overshot, slide"
        # "windowsOut, 1, 4, smoothOut, slide"
        # "windowsMove, 1, 4, default"
        # "fade, 1, 10, smoothIn"
        # "fadeDim, 1, 10, smoothIn"
        # "workspaces, 1, 6, default"
        # "specialWorkspace, 1, 4, default, slidevert "
      ];
    };

    # touchpad gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    xwayland.force_zero_scaling = true;

    # debug.disable_logs = false;

    plugin = {
      csgo-vulkan-fix = {
        res_w = 1280;
        res_h = 800;
        class = "cs2";
      };

      hyprexpo = {
        columns = 3;
        gap_size = 4;
        bg_col = "rgb(000000)";

        enable_gesture = true;
        gesture_distance = 300;
        gesture_positive = false;
      };
    };
  };
}
