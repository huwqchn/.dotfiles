{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-what-time";
  version = "0.1.1";

  src = fetchurl {
    url = "https://github.com/pirafrank/zellij-what-time/releases/download/${version}/zellij-what-time.wasm";
    sha256 = "1c1n1s8ajai0qn4xmxbvc381564hi81lpfaq7vq0a7cm0my93iqj";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin that shows the current time";
    homepage = "https://github.com/pirafrank/zellij-what-time";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
