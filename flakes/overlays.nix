{inputs, ...}: let
  overlays = import ../overlays {inherit inputs;};
in {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      inherit system overlays;
      config = {
        allowAliases = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
    };
  in {
    _module.args.pkgs = pkgs;
  };
}
