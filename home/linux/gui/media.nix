{
  pkgs,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    imv # simple image viewer

    nvtopPackages.full

    # video/audio tools
    cava # for visualizing audio
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
  ];

  # https://github.com/catppuccin/cava
  xdg.configFile."cava/config".text =
    ''
      # custom cava config
      [general]
      mode = waves
      framerate = 120
      sensitivity = 100
      bar_width = 1
      bar_spacing = 2
      [output]
      method = ncurses
      channels = stereo
      mono_option = average
      reverse = 1
      data_format = ascii
      sdl_width = 1000
      sdl_height = 500
      sdl_x = -1
      sdl_y= -1
      xaxis = none
      [color]
      background = default
      foreground = default
    '';

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
