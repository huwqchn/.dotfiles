{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "zellij-sessionizer";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "laperlej";
    repo = "zellij-sessionizer";
    rev = "v${version}";
    hash = "sha256-G2O77M+0ua53WpoNBkE3sNp3yN7uv9byqIteSyEluiQ=";
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
