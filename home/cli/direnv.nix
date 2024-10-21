{config, ...}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config.global = {
        hide_env_diff = true;
      };
    };
  };
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".local/share/direnv/allow"];
  };
}
