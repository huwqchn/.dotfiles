{ pkgs, ... }: {
  home.packages = [ pkgs.conda ];

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

}
