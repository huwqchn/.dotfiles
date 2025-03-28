{
  inputs,
  lib,
  config,
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
