{ lib, ... }: rec {
  colmenaSystem = import ./colmenaSystem.nix;
  macosSystem = import ./macosSystem.nix;
  nixosSystem = import ./nixosSystem.nix;
  
  attrs = import ./attrs.nix { inherit lib; };

  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;
  relativeToConfig = lib.path.append ../config/.;
  symlink = path: config.lib.file.mkOutOfStoreSymlink (relativeToConfig "{path}");
  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (_type == "directory") # include directories
            || (
              (path != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # include .nix files
            )
        )
        (builtins.readDir path)));
}
