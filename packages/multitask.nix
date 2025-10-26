{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "multitask";
  version = "v0.1.0";
  src = fetchurl {
    url = "https://github.com/leakec/multitask/releases/download/0.43.1/multitask.wasm";
    sha256 = "0q2m7j43vmfjcd4zh62qxnr737icrr69gib9q201dc49xwan917h";
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
