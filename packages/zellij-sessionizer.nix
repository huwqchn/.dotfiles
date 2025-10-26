{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-sessionizer";
  version = "v0.4.3";

  src = fetchurl {
    url = "https://github.com/laperlej/zellij-sessionizer/releases/download/${version}/zellij-sessionizer.wasm";
    sha256 = "sha256-0d43jhlhm7p8pvd8kcylfbfy3dahr8q4yngpnjyqivapwip9csq0";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A session manager for Zellij";
    homepage = "https://github.com/laperlej/zellij-sessionizer";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
