set shell := ["fish", "-c"]

switch:
  sudo nixos-rebuild switch --flake .#hacker --show-trace -L -v --impure

nvim-clean:
  rm -rf "$HOME/.config/nvim"

nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 config/nvim/ "$HOME/.config/nvim/"

nvim-readd:
  rm -rf config/nvim/
  mv "$HOME/.config/nvim" config/
