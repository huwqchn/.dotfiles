{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # editor
    neovim
    git
    git-lfs
    just # use Justfile to simplify nix-darwin's commands
    rsync
    cmake
    # darwin only apps
    coreutils
  ];
}
