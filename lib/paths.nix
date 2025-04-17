{lib, ...}: {
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;
  relativeToConfig = lib.path.append ../config/.;
  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          name: _type:
            (_type == "directory" && builtins.pathExists (path + "/${name}/default.nix")) # include directories
            || (
              (name != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" name) # include .nix files
            )
        )
        (builtins.readDir path)));

  sourceLua = path: let
    name = builtins.baseNameOf path;

    # ssourcePath
    sourcePath = "nvim/lua/plugins/extras/${path}";

    # xdg.configFile."key"
    key = "nvim/lua/plugins/${name}";
  in
    # 返回一个 attrset，动态定义了 `${key}.source`
    {"${key}".source = lib.my.relativeToConfig sourcePath;};
}
