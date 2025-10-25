{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "zellij-switch";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "mostafaqanbaryan";
    repo = "zellij-switch";
    rev = version;
    hash = "sha256-Plu/j4DaQMRtygOK0ZXOdlktxfsIzcVCYKrl2rR0dug=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin to switch between different programming language contexts.";
    homepage = "https://github.com/mostafaqanbaryan/zellij-switch";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
