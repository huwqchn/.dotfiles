# modules/dev/python.nix --- https://godotengine.org/
#
# Python's ecosystem repulses me. The list of environment "managers" exhausts
# me. The Py2->3 transition make trainwrecks jealous. But SciPy, NumPy, iPython
# and Jupyter can have my babies. Every single one.
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.develop.python;
  inherit (lib) mkIf mkEnableOption mkMerge;
in {
  options.my.develop.python = {
    enable = mkEnableOption "Python development environment";
    xdg.enable = mkEnableOption "Python XDG environment variables";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        python3
        python3Packages.pip
        python3Packages.ipython
        python3Packages.black
        python3Packages.setuptools
        python3Packages.pylint
        python3Packages.poetry
      ];

      environment.shellAliases = {
        py = "python";
        py2 = "python2";
        py3 = "python3";
        po = "poetry";
        ipy = "ipython --no-banner";
        ipylab = "ipython --pylab=qt5 --no-banner";
      };
    })

    (mkIf cfg.xdg.enable {
      environment.variables = {
        # Internal
        PYTHONPYCACHEPREFIX = "$XDG_CACHE_HOME/python";
        PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
        PYTHONUSERBASE = "$XDG_DATA_HOME/python";
        PYTHON_EGG_CACHE = "$XDG_CACHE_HOME/python-eggs";
        PYTHONHISTFILE = "$XDG_DATA_HOME/python/python_history"; # default value as of >=3.4

        # Tools
        IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
        JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";
        PIP_CONFIG_FILE = "$XDG_CONFIG_HOME/pip/pip.conf";
        PIP_LOG_FILE = "$XDG_STATE_HOME/pip/log";
        PYLINTHOME = "$XDG_DATA_HOME/pylint";
        PYLINTRC = "$XDG_CONFIG_HOME/pylint/pylintrc";
        WORKON_HOME = "$XDG_DATA_HOME/virtualenvs";
      };
    })
  ];
}
