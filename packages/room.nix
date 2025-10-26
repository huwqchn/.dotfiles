{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "room";
  src = fetchFromGitHub {
    owner = "rvcas";
    repo = "room";
    rev = "fd6dc54a46fb9bce21065ce816189c037aeaf24f";
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
