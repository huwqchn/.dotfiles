{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  rev = "acba08810ae8bac60f156361078cef0b5cff0453";
  version = "unstable-${builtins.substring 0 7 rev}";
in
  stdenv.mkDerivation rec {
    pname = "multitask";
    inherit version;
    src = fetchFromGitHub {
      inherit rev;
      owner = "leakec";
      repo = "multitask";
      hash = "sha256-tvxp2xf/KC7Ep3rfFrTQ2Ifh6MErw5dkQI3ZDNjMS/w=";
    };
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "A mini-CI as a Zellij plugin ";
      homepage = "https://github.com/leakec/multitask";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
