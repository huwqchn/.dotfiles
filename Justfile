set shell := ["bash", "-c"]
rebuild := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }
build_config := if os() == "macos" { "darwinConfigurations" } else { "nixosConfigurations" }

# List all the just commands
default:
  @just --list --unsorted

# Build the system configuration
[group('nix')]
build host=`uname -n`:
  nix build .#{{build_config}}.{{host}}.system --extra-experimental-features "nix-command flakes" --show-trace --verbose

# Rebuild specific host using nh
[group('nix')]
switch2 host=`uname -n`:
  nh {{ if os() == "macos" { "darwin" } else { "os" } }} switch . -v -H {{host}} --ask

# Classic cmmand to rebuild nixos
[group('nix')]
switch host=`uname -n`:
  {{rebuild}} switch --flake .#{{host}} --show-trace -L -v

# Deploy the system configuration to a remote host
[group('nix')]
deploy host *args:
  deploy .#{{host}} --skip-checks --remote-build {{args}}

# Install nixos on a machine with an existing operating system
[group('nix')]
install host *args:
  nixos-anywhere \
    --flake .#{{host}} \
    --copy-host-keys \
    --build-on-remote root@{{host}} {{args}}

# Install nixos on a machine with no operating system
[group('nix')]
install2 host ip *args:
  nixos-anywhere  \
    --flake .#{{host}} \
    --copy-host-keys \
    --build-on-remote nixos@{{ip}} {{args}}

# Create disks
[group('nix')]
disko host:
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
    --mode disko \
    --flake .#{{host}}
  nixos-install --flake .#{{host}}

# Remove all generations order than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  nix-collect-garbage --delete-older-than 7d
  nix store optimise

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

# Check the flake
[group('nix')]
check *args:
  nix flake check {{args}}

# Create a clean and simple shell with git and neovim
[group('nix')]
shell:
  nix shell nixpkgs#git nixpkgs#neovim

# Open my develop shell whicih is defined in this repo
[group('nix')]
dev name="default":
  nix develop .#{{name}}

# Format the nix files in this repo
[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

# Reload nix direnv
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


# Remove this program's configuration folder
[group('dev')]
rm program:
  rm -rf "$HOME/.config/{{program}}"

# Move this program's configuration folder from my repo to the config folder for devvelopment
[group('dev')]
cfg program:
  just rm {{program}}
  rsync -avz --copy-links --chmod=D2755,F744 config/{{program}}/ "$HOME/.config/{{program}}/"

# Backup this program's configuration folder to my repo
[group('dev')]
add program:
  rm -rf config/{{program}}/
  mv "$HOME/.config/{{program}}" config/
