{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-autolock";
  version = "0.2.2";
  src = fetchurl {
    url = "https://github.com/fresh2dev/zellij-autolock/releases/download/${version}/zellij-autolock.wasm";
    sha256 = "194fgd421w2j77jbpnq994y2ma03qzdlz932cxfhfznrpw3mdjb9";
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
