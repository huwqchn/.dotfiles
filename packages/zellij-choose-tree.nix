{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  version = "0.4.2";
in
  stdenv.mkDerivation rec {
    pname = "zellij-choose-tree";
    inherit version;
    src = fetchFromGitHub {
      owner = "laperlej";
      repo = "zellij-choose-tree";
      rev = "v${version}";
      hash = "sha256-g6R+LfSN7IgRPWr7sf3mLIn6c2xP/oaFO/MsxX7oB0s=";
    };
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "zellij-choose-tree is a plugin for zellij that allows users to quickly switch between sessions.";
      homepage = "https://github.com/laperlej/zellij-choose-tree";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
