{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    firefox-wayland
    google-chrome
  ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".cache/mozilla/firefox"
      ".config/google-chrome"
    ];
  };
}
