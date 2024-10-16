{
  config,
  pkgs,
  zen-browser,
  ...
}: {
  home.packages = [
    zen-browser.packages.${pkgs.system}.default
  ];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".zen"
      ".cache/zen"
    ];
  };
}
