{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  rev = "fd6dc54a46fb9bce21065ce816189c037aeaf24f";
in
  stdenv.mkDerivation rec {
    pname = "room";
    version = "unstable-${builtins.substring 0 7 rev}";
    src = fetchFromGitHub {
      inherit rev;
      owner = "rvcas";
      repo = "room";
      hash = "sha256-T1JNFJUDCtCjXtZQUe1OQsfL3/BI7FUw60dImlUmLhg=";
    };
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "A Zellij plugin for quickly searching and switching tabs";
      homepage = "https://github.com/rvcas/room";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
