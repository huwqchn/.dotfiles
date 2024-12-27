{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands
  ];
  environment.variables.EDITOR = "nvim";

  # To make this work, homebrew need to be installed manually, see https://brew.sh
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

    # Applications to install from Mac App Store using mas
    # You need to install all these Apps manually first so that your apple accound have records for them.
    # otherwise Apple Store will refuse to install them
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      Xcode = 497799835

    };

    taps = [
      "homebrew/services"
      "benjiwolff/neovim-nightly"
    ];

    # `brew install`
    brews = [
      "wget"
      "curl"
      "aria2" # download tool
      "httpie" # http client

      # https://github.com/rgcr/m-cli
      "m-cli" #  Swiss Army Knife for macOS
      "proxychains-ng"

      # commands like `gsed` `gtar` are required by some tools
      "gnu-sed"
      "gnu-tar"
      # misc that nix do not have cache for.
      "git-trim"
      "terraform"
      "terraformer"
    ];

    # `brew install --cask`
    casks = [
      "squirrel" # input method for Chinese, rime-squirrel
      "zen-browser" # web browser
      "zed" # zed editor
      "aerospace" # an i3-like tiling window manager for macOS
      "viusal-studio-code" # editor
      "discord" # IM
      "iina" # video player
      "raycast" # search
      "stats" # beautiful system monitor
      "eudic" # dictionary
      "spotify" # music
      "curseforge" # game extensions
      "steam" # game platform
      "uu-booster" # game booster
      "1password" # password manager
      "1password-cli"
      "ghostty" # terminal
      "obsidian" # note-taking
      "miniforge" # Miniconda's community-driven distribution
      "cleanmymac-zh" # clean tool
      "surge" # proxy tool

    ];
  };
}
