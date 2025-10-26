{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  rev = "ec980abab220a1ec0a4434b283ea160838219321";
  version = "unstable-${builtins.substring 0 7 rev}";
in
  stdenv.mkDerivation rec {
    pname = "monocle";
    inherit version;

    src = fetchFromGitHub {
      inherit rev;
      owner = "imsnif";
      repo = "monocle";
      hash = "sha256-LZQn4aXroYPpn6pMydo3R4mEcZpUm2m6CDSY4azrJlw=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "A Zellij plugin to fuzzy find file names and contents in style";
      homepage = "https://github.com/imsnif/monocle";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
