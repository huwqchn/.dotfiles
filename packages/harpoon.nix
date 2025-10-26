{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  rev = "34b71b88f56fa8f066c5eed07d43b20ed01dc130";
  version = "unstable-${builtins.substring 0 7 rev}";
in
  stdenv.mkDerivation rec {
    pname = "harpoon";
    inherit version;

    src = fetchFromGitHub {
      inherit rev;
      owner = "Nacho114";
      repo = "harpoon";
      hash = "sha256-NwZWFIocBAXoPbqdKoyatG9XYIvJ2fLhfuHTRQNVqNk=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "Zellij plugin to quickly navigate your panes (clone of nvim's harpoon)";
      homepage = "https://github.com/Nacho114/harpoon";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
