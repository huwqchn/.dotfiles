{
  system = "aarch64-darwin";
  modules = [
    {
      my.desktop.enable = true;
    }
    ./common/yubikey.nix
  ];
}
