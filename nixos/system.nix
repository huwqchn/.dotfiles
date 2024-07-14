{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    just
  ];
  
  # virtualisation
  programs.virt-manager.enable = true;
  virtualisation = {
    podman.enable = true;
    docker.enable = true;
    libvirtd.enable = true;
  };
  
  # boot
  boot.loader.systemd-boot.enable = false;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;

      dedsec-theme = {
        enable = true;
	style = "compact";
	icon = "color";
	resolution = "1080p";
      };
    };
  };

  # define hostname
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
 
  # set time zone
  time.timeZone = "Asia/Shanghai";
  
  # set internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  system.stateVersion = "24.05"; # Don't change this
}
