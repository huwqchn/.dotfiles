{ pkgs, ... }: {
  # auto mount usb drives
  services = {
    udiskie.enable = true;
  };
}
