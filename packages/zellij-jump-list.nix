{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  rev = "71695202d2b7ecd0caaa27708ab8a257da675a93";
  version = "unstable-${builtins.substring 0 7 rev}";
in
  stdenv.mkDerivation rec {
    pname = "zellij-jump-list";
    inherit version;

    src = fetchFromGitHub {
      inherit rev;
      owner = "blank2121";
      repo = "zellij-jump-list";
      hash = "sha256-VT/Tyc701g1eHFvBNshqC2g4JaguLtaYH0L18PFOKRU=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "A zellij plugin that provides a jump list like feature.";
      homepage = "https://github.com/blank2121/zellij-jump-list";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
