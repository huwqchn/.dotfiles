switch:
  sudo nixos-rebuild switch --flake .#nixos --show-trace -L -v --impure

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

  # garbage collect all unused nix store entries
  sudo nix store gc --debug


fmt:
  # format the nix files in this repo
  nix fmt

clean:
  rm -rf result

darwin:
  nix build .#darwinConfigurations.dailydev.system \
    --extra-experimental-features 'nix-command flakes'
  