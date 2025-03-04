{
  darwin,
  home-manager,
  agenix,
  ...
}: {
  system = "aarch64-darwin";

  modules = [
    ./config.nix
  ];
}
