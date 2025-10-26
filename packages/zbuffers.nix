{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  version = "0.4.0";
in
  stdenv.mkDerivation rec {
    pname = "zbuffers";
    inherit version;
    src = fetchFromGitHub {
      owner = "Strech";
      repo = "zbuffers";
      rev = "v${version}";
      hash = "sha256-5Yrp10ONwNRryLkgbWK3WmnKVjbZH5PWvTTKbnLPDHA=";
    };
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "Zellij plugin for convenient switching between tabs with search capabilities";
      homepage = "https://github.com/Strech/zbuffers";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
