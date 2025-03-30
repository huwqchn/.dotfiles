{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault mkForce;
  isWsl = config.my.machine.type == "wsl";
in {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  config = mkIf isWsl {
    my = {
      machine = {
        gpu = null;
        cpu = null;
        hasTPM = false;
        hasSound = false;
        isHidpi = true;
        persist = mkForce false;
      };
      boot = {
        loader = "none";
        secureBoot = false;
        tmpOnTmpfs = true;
        enableKernelTweaks = true;
        loadRecommendedModules = true;
        plymouth.enable = false;

        initrd = {
          enableTweaks = true;
          optimizeCompressor = true;
        };
      };
      video.enable = mkForce false;
      game.enable = mkForce false;
      security = {
        enable = false;
        auditd.enable = true;
      };
      desktop = {
        enable = mkDefault false;
        apps.enable = mkForce false;
        wayland.enable = mkDefault true;
        loginManager = mkForce null;
      };
      virtual = {
        enable = mkForce false;
        docker.enable = config.my.desktop.enable;
      };
      yubikey.enable = mkForce false;
    };
    hm.my = {
      desktop.enable = mkDefault false;
      terminal = null;
      browser = null;
      fastfetch.startOnLogin = mkDefault false;
      tmux.autoStart = mkForce false; # I don't know how to auto start tmux in wsl, never work, break my shell!!!
    };
    wsl = {
      enable = true;
      wslConf = {
        automount.root = "/mnt";
        interop.appendWindowsPath = false;
        network.gnerateHosts = false;
      };
      defaultUser = config.my.name;
      startMenuLaunchers = true;

      interop = {
        includePath = false;
        register = true;
      };

      # enable integration with Docker Desktop (needed to be installed)
      docker-desktop.enable = config.my.desktop.enable;
    };
    networking = {
      useNetworkd = lib.mkForce false;
      nftables.enable = lib.mkForce false;
      extraHosts = lib.mkForce '''';
      tcpcrypt.enable = lib.mkForce false;
    };
    # other
    services = {
      # that's not make sense on WSL
      smartd.enable = mkForce false;
      thermald.enable = mkForce false;
      resolved.enable = mkForce false;
      earlyoom.enable = mkForce false;
    };

    environment = {
      variables.BROWSER = mkForce "wsl-open";
      systemPackages = [pkgs.wsl-open];
    };
  };
}
