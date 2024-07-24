{ config, lib, pkgs, ... }:
let
  # Homebrew Mirror
  homebrew_mirror_env = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };
  homebrew_env_script = 
    lib.attrsets.foldlAttrs
    (acc: name: value: acc + "\nexport ${name}=${value}") 
    ""
    homebrew_mirror_env;
in {
  # Set environment variables for nix-darwin before run `brew bundle`.
  system.activationScripts.homebrew.text = lib.mkBefore ''
    echo >&2 '${homebrew_env_script}'
    ${homebrew_env_script}
  '';
  ##########################################################################
  # 
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  # 
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands 
  ];

  environment.variables = 
    {
            # Fix https://github.com/LnL7/nix-darwin/wiki/Terminfo-issues
      TERMINFO_DIRS = map (path: path + "/share/terminfo") config.environment.profiles ++ ["/usr/share/terminfo"];

      EDITOR = "nvim";
    }
    # Set variables for you manually install homebrew packages.
    // homebrew_mirror_env;

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # 
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      Xcode = 497799835;
      Wechat = 836500024;
      NeteaseCloudMusic = 944848654;
      QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      TecentMetting = 1484048379;
      # QQMusic = 595615424;
      Noizio = 928871589; # for focus, relax and sleep
      Parallels-Desttop = 1085114709;
      Things = 904280696;
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "aria2" # download tool
      "httpie" # http client
    ];

    # `brew install --cask`
    casks = [
      # my passwords manager
      "1password@nightly"
      "1password-cli"

      # browsers
      "arc"
      "firefox"
      "google-chrome"
      "microsoft-edge"

      # system utilities
      "cleanmymac-zh"
      "daisydisk"
      "surge"
      "one-switch"
      "bartender"
      "onedrive"
      "istat-menus"
      "adguard@nightly"
      "cheatsheet"
      "keycastr"

      # editor
      "visual-studio-code"
      # note take editor
      "obsidian"
      "anki"

      # IM & audio & remote desktop & meeting
      "telegram"
      "discord"

      # music player
      "spotify"

      "iina" # video player
      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      "stats" # beautiful system monitor
      "eudic" # 欧路词典

      "clash-verge-rev"

      # Development
      "insomnia" # REST client
      "wireshark" # network analyzer
    ];
  };
}