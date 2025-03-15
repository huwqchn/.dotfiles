set shell := ["bash", "-c"]
rebuild := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }
build_config := if os() == "macos" { "darwinConfigurations" } else { "nixosConfigurations" }

# List all the just commands
default:
    @just --list

[group('nix')]
build host=`uname -n`:
  nix build .#{{build_config}}.{{host}}.system --extra-experimental-features "nix-command flakes" --show-trace --verbose

# Rebuild specific host
[group('nix')]
switch host=`uname -n`:
  {{rebuild}} switch --flake .#{{host}} --show-trace -L -v

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
dev name="default":
  nix develop .#{{name}}

[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

# reload nix direnv
[group('nix')]
reload:
  nix-direnv-reload

# Verify all the store entries
# Nix Store can contains corrupted entries if the nix store object has been modified unexpectedly.
# This command will verify all the store entries,
# and we need to fix the corrupted entries manually via `sudo nix store delete <store-path-1> <store-path-2> ...`
[group('nix')]
verify:
  nix store verify --all

# Repair Nix Store Objects
[group('nix')]
repair *paths:
  nix store repair {{paths}}


[group('dev')]
rm program:
  rm -rf "$HOME/.config/{{program}}"

[group('dev')]
cfg program:
  just rm {{program}}
  rsync -avz --copy-links --chmod=D2755,F744 config/{{program}}/ "$HOME/.config/{{program}}/"

[group('dev')]
add program:
  rm -rf config/{{program}}/
  mv "$HOME/.config/{{program}}" config/
