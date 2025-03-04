{
  inputs,
  lib,
  ...
}: {
  perSystem = {lib, ...}: {
    _modules.args.lib = lib.extend (final: _:
      {
        my = import ../lib {lib = final;};
      }
      // inputs.home-manager.lib);
  };
  imports = lib.my.scanPaths ./.;
}
