{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zj-status-bar";
  version = "0.3.0";

  src = fetchurl {
    url = "https://github.com/cristiand391/zj-status-bar/releases/download/${version}/zj-status-bar.wasm";
    sha256 = "1s091b9hv4bsh0mbz7g9di8l8bzbhh1srmvsq71mk41bvc59ds5i";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A status bar for Zellij";
    homepage = "https://github.com/cristiand391/zj-status-bar";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
