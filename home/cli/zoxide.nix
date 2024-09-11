{config, ...}: {
  programs.zoxide = {
    enable = true;
  };
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".local/share/zoxide"];
  };
}
