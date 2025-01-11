{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands
    rsync
    cmake
    # darwin only apps
    utm # virtual machine
  ];

  environment.shells = [
    pkgs.zsh
    pkgs.fish
  ];

  programs.fish.enable = true;

  # Requires Homebrew to be installed
  system.activationScripts.preUserActivation.text = ''
    if ! xcode-select --version 2>/dev/null; then
      $DRY_RUN_CMD xcode-select --install
    fi
    if ! /opt/homebrew/bin/brew --version 2>/dev/null; then
      $DRY_RUN_CMD /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    global = {
      brewfile = true; # Run brew bundle from anywhere
      lockfiles = false; # Don't save lockfile (since running from anywhere)
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

    taps = [
      "homebrew/services"
      "benjiwolff/neovim-nightly"
      "hashicorp/tap"
      "nikitabobko/tap" # aerospace - an i3-like tiling window manager for macOS
      "FelixKratz/formulae" # janky borders - highlight active window borders
    ];

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
    ];

    # `brew install --cask`
    casks = [
      "squirrel" # input method for Chinese, rime-squirrel
      "zen-browser" # web browser
      "zed" # zed editor
      "aerospace" # an i3-like tiling window manager for macOS
      "visual-studio-code" # editor
      # "discord" # update too frequently, use the web version instead
      "telegram" # IM
      "rustdesk" # remote desktop client
      # "iina" # video player
      "raycast" # search
      "stats" # beautiful system monitor
      "eudic" # dictionary
      "spotify" # music
      "1password" # password manager
      "1password-cli"
      "ghostty" # terminal
      "obsidian" # note-taking
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
      "karabiner-elements" # keyboard remap
    ];
  };
}
