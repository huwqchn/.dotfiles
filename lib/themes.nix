{lib, ...}: {
  capitalize = str:
    lib.strings.concatStrings [
      (lib.strings.toUpper (lib.strings.substring 0 1 str))
      (lib.strings.substring 1 (lib.strings.stringLength str - 1) str)
    ];
}
