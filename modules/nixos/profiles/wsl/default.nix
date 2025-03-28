{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (config.my) machine;
  inherit (lib.modules) mkIf mkDefault mkForce;
in {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  config = mkIf (machine.type == "wsl") {
    my = {
      machine = {
        type = "wsl";
        gpu = null;
        cpu = null;
        hasTPM = false;
        monitor = [];
        hasSound = false;
        isHidpi = true;
        persist = false;
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
        audit.enable = true;
      };
      desktop = {
        enable = mkDefault false;
        wayland.enable = mkDefault true;
        default = mkDefault "hyprland";
        loginManager = mkForce null;
      };
      virtual = {
        enable = mkForce false;
        docker = config.my.desktop.enable;
      };
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

      # enable integration with Docker Desktop (needed to be installed)
      docker-desktop.enable = config.my.desktop.enable;
    };
    networking = {
      useNetworkd = lib.mkForce false;
      nftables.enable = lib.mkForce false;
      extraHosts = lib.mkForce '''';
    };
  };
}
