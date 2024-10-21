set shell := ["bash", "-c"]

# List all the just commands
default:
    @just --list

# Run eval tests
[group('nix')]
test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

[group('nix')]
rebuild host:
  nh os switch . -v -H {{host}} --ask
  # sudo nixos-rebuild switch --flake .#{{host}} --show-trace -L -v --impure

[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

[group('nix')]
gc:
  nix-collect-garbage --delete-older-than 3d
  nix store optimize

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

[group('nix')]
check:
  nix flake check

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
