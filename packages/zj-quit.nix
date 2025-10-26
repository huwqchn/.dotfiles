{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zj-quit";
  version = "0.3.1";

  src = fetchurl {
    url = "https://github.com/cristiand391/zj-quit/releases/download/${version}/zj-quit.wasm";
    sha256 = "153z2gdb7vfppz9ip3bs6pfmb1ypzj1q6k38l91b6j3nccc2f9i5";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A Zellij plugin that asks for confirmation before quitting.";
    homepage = "https://github.com/cristiand391/zj-quit";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
