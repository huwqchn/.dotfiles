{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ./environment.nix
  ];

  # brought in using nix-homebrew to make homebrew apps reproducible
  nix-homebrew = {
    enable = true;

    # I want to force us to only use declarative taps
    mutableTaps = false;

    # we need a user to install packages for
    user = config.my.name;

    # to truly be declarative, we need to specify the exact revision of homebrew-core
    #
    # you can run the following command to get the latest rev and hash of homebrew-core
    # nix-prefetch-github homebrew homebrew-core --nix
    taps = {
      "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
        owner = "homebrew";
        repo = "homebrew-core";
        rev = "6be8100cb572f35a9ec16bc9dcc33cbc37289554";
        hash = "sha256-AL4atzOAGd8QYWODiIppAzV4NWsmOcyhSK0MbDnP3rs=";
      };
      "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
        owner = "homebrew";
        repo = "homebrew-cask";
        rev = "8b1be4b3dab0a2c089723e519e14ad8c3721ba69";
        hash = "sha256-eYRvTXwFJ5Ti0O0fJCQru1B4efNITpUS0jCghe1tHQs=";
      };
      "nikitabobko/homebrew-tap" = pkgs.fetchFromGitHub {
        owner = "nikitabobko";
        repo = "homebrew-tap";
        rev = "f48b006349858421c650551034c2c3beaea2936b";
        hash = "sha256-IW8C2HtlLLGTylUou6OcLW2juLe1yNX+Ikj0yQPfa48=";
      };
    };
  };

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    global.autoUpdate = false;

    onActivation = {
      # autoUpdate = true; # this should be managered by nix-homebrew
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      Xcode = 497799835;
      Wechat = 836500024;
      QQ = 451108668;
      # WeCom = 1189898970; # Wechat for Work
      TecentMeeting = 1484048379;
      OneDrive = 823766827;
    };

    # if we don't do this nix-darwin may attempt to remove our taps
    # even when they are managed by nix-homebrew
    taps = builtins.attrNames config.nix-homebrew.taps;

    # `brew install`
    brews = [
      "reattach-to-user-namespace" # need by tmux
      "wget"
      "curl"
      "aria2" # download tool
      "httpie" # http client

      # https://github.com/rgcr/m-cli
      "m-cli" #  Swiss Army Knife for macOS

      # commands like `gsed` `gtar` are required by some tools
      "gnu-sed"
      "gnu-tar"
      # misc that nix do not have cache for.
      "git-trim"
      "terraform"
      "terraformer"
      # for development
      "qt@5"
      "openssh"
    ];

    # `brew install --cask`
    casks = [
      "squirrel" # input method for Chinese, rime-squirrel
      "zen-browser" # web browser
      # "visual-studio-code" # editor
      # "discord" # update too frequently, use the web version instead
      # "telegram" # IM
      "rustdesk" # remote desktop client
      # "iina" # video player
      "raycast" # search
      "stats" # beautiful system monitor
      "eudic" # dictionary
      # "spotify" # music
      "1password" # password manager
      "1password-cli"
      "vlc" # video player
      "obs" # stream / recoding software
      "ghostty" # terminal
      # "obsidian" # note-taking
      "miniforge" # Miniconda's community-driven distribution
      "tencent-lemon" # clean tool
      "surge" # proxy tool
      "miniforge" # Miniconda's community-driven distribution
      "keycastr" # show keystrokes on screen
      # "obs" # stream / recoding software
      "chatgpt" # open ai desktop
      # virtualization
      "utm" # virtual machines
      "docker" # docker desktoplient
      # "karabiner-elements" # keyboard remap
      "yubico-authenticator" # for yubikey
      "veracrypt" # disk encryption
      # sing-box
      "sfm"
      # for work
      "wpsoffice"
    ];
  };
}
