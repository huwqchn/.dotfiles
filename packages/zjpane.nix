{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zjpane";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "FuriouZz";
    repo = "zjpane";
    rev = "v${version}";
    hash = "sha256-PnlXqyCWf9iK+jutnOkn0ZbvqVFrH0kBjc4IqL1J1Io=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "Zellij plugin to navigate between panes and create new ones";
    homepage = "https://github.com/FuriouZz/zjpane";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
