{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "jbz";

  src = fetchFromGitHub {
    owner = "nim65s";
    repo = "jbz";
    rev = "e547d0386b07390587290273f633f1fdf90303c4";
    hash = "sha256-vDCRR/sFwCF6/ZYaZIVh9dnGNd4hh/f1JjDEPwQTxgU=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A Zellij plugin to display your just commands wrapped in bacon";
    homepage = "https://github.com/nim65s/jbz";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
