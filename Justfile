set shell := ["fish", "-c"]

# List all the just commands
default:
    @just --list

# Run eval tests
[group('nix')]
test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

[group('nix')]
switch host:
  sudo nixos-rebuild switch --flake .#{{host}} --show-trace -L -v --impure

[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

[group('nix')]
gc:
  nix-collect-garbage --delete-older-than 1d

[group('nix')]
up:
  nix flake update

[group('nix')]
upp input:
  nix flake update {{input}}

[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

[group('nix')]
repl:
  nix repl -f flake:nixpkgs

[group('neovim')]
nvim-clean:
  rm -rf "$HOME/.config/nvim"

[group('neovim')]
nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 config/nvim/ "$HOME/.config/nvim/"

[group('neovim')]
nvim-readd:
  rm -rf config/nvim/
  mv "$HOME/.config/nvim" config/
