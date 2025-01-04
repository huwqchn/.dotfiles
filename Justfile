set shell := ["bash", "-c"]

# List all the just commands
default:
    @just --list

# Run eval tests
[group('nix')]
test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

# Rebuild specific host
[group('nix')]
rebuild host:
  nh os switch . -v -H {{host}} --ask
  # sudo nixos-rebuild switch --flake .#{{host}} --show-trace -L -v --impure

# remove all generations order than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  nix-collect-garbage --delete-older-than 7d
  nix store optimize

# Update all the flake inputs
[group('nix')]
up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}}

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

[group('nix')]
check:
  nix flake check

[group('nix')]
shell:
  nix shell nixpkgs#git nixpkgs#neovim

[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

# Verify all the store entries
# Nix Store can contains corrupted entries if the nix store object has been modified unexpectedly.
# This command will verify all the store entries,
# and we need to fix the corrupted entries manually via `sudo nix store delete <store-path-1> <store-path-2> ...`
[group('nix')]
verify-store:
  nix store verify --all

# Repair Nix Store Objects
[group('nix')]
repair-store *paths:
  nix store repair {{paths}}

[macos]
[group('nix')]
darwin-build host:
  nix build .#darwinConfigurations.{{host}}.system --extra-experimental-features "nix-command flakes" --show-trace --verbose

[macos]
darwin-switch host:
  ./result/sw/bin/darwin-rebuild switch --flake .#{{host}} --show-trace -L -v --impure

[group('dev')]
rm program:
  rm -rf "$HOME/.config/{{program}}"

[group('dev')]
dev program:
  just rm {{program}}
  rsync -avz --copy-links --chmod=D2755,F744 config/{{program}}/ "$HOME/.config/{{program}}/"

[group('dev')]
add program:
  rm -rf config/{{program}}/
  mv "$HOME/.config/{{program}}" config/
