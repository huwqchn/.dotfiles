{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `mylib.nixosSystem`, `mylib.colmenaSystem`, etc.
  inputs,
  lib,
  myvars,
  mylib,
  system,
  genSpecialArgs,
  ...
} @ args: let
  name = "hacker";
  modules = {
    nixos-modules = 
      (map mylib.relativeToRoot [
        "hosts/${name}"
        "modules/base.nix"
        "modules/nixos/base"
        "modules/nixos/desktop"
        # "modules/nixos/desktop/game"
        # "modules/nixos/desktop/fhs.nix"
        # "modules/nixos/desktop/fonts.nix"
        # "modules/nixos/desktop/graphic.nix"
        # "modules/nixos/desktop/guix.nix"
        # "modules/nixos/desktop/misc.nix"
        # "modules/nixos/desktop/peripherals.nix"
        # "modules/nixos/desktop/security.nix"
        # "modules/nixos/desktop/virtualisation.nix"
        # "modules/nixos/desktop/wayland.nix"
        "modules/nixos/desktop.nix"
      ])
      ++ [
        {
          modules.desktop.wayland.enable = true;
        }
      ];
    home-modules = 
      (map mylib.relativeToRoot [

        "hosts/${name}/home.nix"
        "home/base"
        "home/linux"
      ]) 
      ++ [
        {
          modules.desktop.hyprland.enable = true;
        }
      ];
  };

  systemArgs = modules // args;

in {
  nixosConfigurations.${name} = mylib.nixosSystem systemArgs;
  packages.${name} = inputs.self.nixosConfigurations.${name}.config.formats.iso;
}
