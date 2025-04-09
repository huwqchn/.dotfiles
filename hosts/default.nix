{
  modules = [
    {
      hm.imports = [
        ./common/nvim.nix
        ./common/cli.nix
      ];
    }
    ./common/yubikey.nix
  ];
  deployable = true;
}
