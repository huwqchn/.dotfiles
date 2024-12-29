{
  config,
  pkgs,
  myvars,
  ...
}: {
  environment = {
    # add user's shell into /etc/shells
    shells = with pkgs; [
      bashInteractive
      fish
    ];
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      gnumake
    ];
    variables = {
      # fix https://github.com/NixOS/nixpkgs/issues/238025
      TZ = "${config.time.timeZone}";
      # fix kitty/wezterm not able to input Chinese
      # https://github.com/kovidgoyal/kitty/issues/403
      GLFW_IM_MODULE = "ibus";
    };
  };

  users = {
    # set user's default shell system-wide
    defaultUserShell = pkgs.bashInteractive;
    users.${myvars.userName}.shell = pkgs.fish;
  };

  # fix for `sudo xxx` in kitty/wezterm and other modern terminal emulators
  security.sudo.keepTerminfo = true;

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  programs = {
    # The OpenSSH agent remembers private keys for you
    # so that you don’t have to type in passphrases every time you make an SSH connection.
    # Use `ssh-add` to add a key to the agent.
    ssh.startAgent = true;
    # dconf is a low-level configuration system.
    dconf.enable = true;
    # fish
    fish.enable = true;

    # thunar file manager(part of xfce) related options
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # nix cli helper
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 3d --key 5";
      };
      flake = "/home/${myvars.userName}/.dotfiles";
    };
  };
}
