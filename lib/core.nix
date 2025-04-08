# This is the very core of the lib.
# IT MUST ONLY DEPEND ON ITSELF OR EXTERNAL LIBS TO AVOID INFINITE RECURSION.
{lib, ...}: rec {
  # Merges a list of attributes into one, including lists and nested attributes.
  # Use this instead of lib.mkMerge if the merge type isn't allowed somewhere.
  # https://stackoverflow.com/a/54505212
  deepMerge = attrs: let
    merge = path:
      builtins.zipAttrsWith (n: values:
        if builtins.tail values == []
        then builtins.head values
        else if builtins.all builtins.isList values
        then lib.unique (lib.concatLists values)
        else if builtins.all builtins.isAttrs values
        then merge (path ++ [n]) values
        else lib.last values);
  in
    merge [] attrs;

  # Imports and merges all modules in a path's module's `imports` recursively.
  # Use this in case you want to resolve modules somewhere they're not, or if
  # you don't want the default merge behavior.
  resolveImports = file: args: let
    module = import file args;
  in
    if module ? imports
    then
      deepMerge ([module]
        ++ (builtins.map (submodule: resolveImports submodule args)
          module.imports))
    else module;

  # Imports and merges a list of module paths.
  importAndMerge = paths: args: let
    modules = builtins.map (file: import file args) paths;
  in
    deepMerge modules;

  # Override nixpkgs.lib.types.attrs to be deep-mergible. This avoids configs
  # from mistakenly overriding values due to the use of `//`.
  types.attrs.merge = _: definitions: let
    values = builtins.map (definition: definition.value) definitions;
  in
    deepMerge values;

  # Concatinatinates all file paths in a given directory into one list.
  # It recurses through subdirectories. If it detects a default.nix, only that
  # file will be considered.
  #
  # This function is copied from:
  # https://github.com/yunfachi/nypkgs/blob/master/lib/umport.nix
  #
  # !!! REMOVING THIS NOTICE VIOLATES THE MIT LICENSE OF THE UMPORT PROJECT !!!
  # This notice must be retained in all copies of this function, including modified versions!
  # The MIT License can be found here:
  # https://github.com/yunfachi/nypkgs/blob/master/LICENSE
  concatImports = {
    path ? null,
    paths ? [],
    include ? [],
    exclude ? [],
    recursive ? true,
    filterDefault ? true,
  }:
    with lib;
    with fileset; let
      excludedFiles = filter pathIsRegularFile exclude;
      excludedDirs = filter pathIsDirectory exclude;
      isExcluded = path:
        if elem path excludedFiles
        then true
        else
          (filter (excludedDir: outputs.lib.path.hasPrefix excludedDir path)
            excludedDirs)
          != [];

      myFiles = unique ((filter (file:
          pathIsRegularFile file
          && hasSuffix ".nix" (builtins.toString file)
          && !isExcluded file) (concatMap (_path:
            if recursive
            then toList _path
            else
              mapAttrsToList (name: type:
                _path
                + (
                  if type == "directory"
                  then "/${name}/default.nix"
                  else "/${name}"
                )) (builtins.readDir _path))
          (unique (
            if path == null
            then paths
            else [path] ++ paths
          ))))
        ++ (
          if recursive
          then concatMap toList (unique include)
          else unique include
        ));

      dirOfFile = builtins.map (file: builtins.dirOf file) myFiles;

      dirsWithDefaultNix =
        builtins.filter (dir: builtins.elem dir dirOfFile)
        (builtins.map (file: builtins.dirOf file) (builtins.filter (file:
          builtins.match "default.nix" (builtins.baseNameOf file) != null)
        myFiles));

      filteredFiles = builtins.filter (file:
        !builtins.elem (builtins.dirOf file) dirsWithDefaultNix
        || builtins.match "default.nix" (builtins.baseNameOf file) != null)
      myFiles;
    in
      if filterDefault
      then filteredFiles
      else myFiles;
}
