{
  pkgs,
  config,
  lib,
  ...
}:
lib.my.mkEnabledModule config "conda" {
  home.packages = [pkgs.conda];

  home.file.".condarc" = {
    text = ''
      channels:
        - conda-forge
        - defaults
      env_prompt: \'\'
      auto_activate_base: false
    '';
    executable = false;
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".conda"];
  };
}
