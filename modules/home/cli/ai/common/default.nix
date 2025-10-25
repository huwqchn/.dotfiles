{lib, ...}: let
  shared = import ./shared.nix {inherit lib;};
in {
  _module.args.aiCommon = shared;
}
