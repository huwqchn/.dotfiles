{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-forgot";

  src = fetchFromGitHub {
    owner = "karimould";
    repo = "zellij-forgot";
    rev = "3cc723b5741e8a26fe3c8f50756705e8c68d223b";
    hash = "sha256-fftXugdUy/UQ3lKwsugL0xjbDCjppRekUXFbtZ10gE0=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin that allows you to close tabs without closing the session";
    homepage = "https://github.com/karimould/zellij-forgot";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
