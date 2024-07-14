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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
