{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    google-chrome
  ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".config/google-chrome"
    ];
  };
}
