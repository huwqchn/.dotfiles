{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zj-quit";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "cristiand391";
    repo = "zj-quit";
    rev = version;
    hash = "sha256-APimuHdhfxIBGIzCkT42+wSQCDv5Do5OKtmr997Usfs=";
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
