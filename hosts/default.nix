{
  modules = [
    ../secrets
    {
      hm.imports = [
        ./common/nvim.nix
        ./common/cli.nix
      ];
    }
  ];
}
