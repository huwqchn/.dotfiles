{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  version = "0.1.8";
in
  stdenv.mkDerivation rec {
    pname = "zellij-favs";
    inherit version;
    src = fetchFromGitHub {
      owner = "JoseMM2002";
      repo = "zellij-favs";
      rev = "v${version}";
      hash = "sha256-eYnMmPyACaobOCs2Pr0X4sr8CWfQPX3uVAIa/1/BlJU=";
    };
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "A simple and intuitive plugin for managing favorite sessions in Zellij. Easily organize and switch between sessions with ease.";
      homepage = "https://github.com/JoseMM2002/zellij-favs";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
