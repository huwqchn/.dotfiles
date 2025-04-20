{lib, ...}: let
  capitalize = str:
    lib.strings.concatStrings [
      (lib.strings.toUpper (lib.strings.substring 0 1 str))
      (lib.strings.substring 1 (lib.strings.stringLength str - 1) str)
    ];
  # removeHashTag { a= "#ff0000"; b = "#0f0"; } => { a = "ff0000"; b = "0f0"; }
  removeHashTag = palette:
    builtins.mapAttrs (
      _: value: let
        len = builtins.stringLength value;
        prefix = builtins.substring 0 1 value;
      in
        if prefix == "#"
        then builtins.substring 1 (len - 1) value
        else value
    )
    palette;
in {
  inherit removeHashTag capitalize;
}
