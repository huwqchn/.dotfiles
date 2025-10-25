{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "zj-status-bar";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "cristiand391";
    repo = "zj-status-bar";
    rev = version;
    hash = "sha256-mIXoCep3L/A9hPSPClINUxjTaVAT+N65pQP3V+Wl4gc=";
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
