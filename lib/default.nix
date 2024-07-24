{ config,lib, ... }: rec {
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;
  symlink = path: config.lib.file.mkOutOfStoreSymlink (relativeToRoot "config/${path}");
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
