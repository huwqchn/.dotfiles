{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: let
  version = "0.2.2";
in
  stdenv.mkDerivation rec {
    pname = "zellij-autolock";
    inherit version;
    src = fetchFromGitHub {
      owner = "fresh2dev";
      repo = "zellij-autolock";
      rev = version;
      hash = "sha256-uU7wWSdOhRLQN6cG4NvA9yASlvRwB6gggX89B5K9dyQ";
    };
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${pname}.wasm
      chmod +x $out/bin/${pname}.wasm
    '';

    meta = with lib; {
      description = "autolock Zellij when certain processes open.";
      homepage = "https://github.com/fresh2dev/zellij-autolock";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  }
