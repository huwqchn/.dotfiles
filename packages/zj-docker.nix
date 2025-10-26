{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zj-docker";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "dj95";
    repo = "zj-docker";
    rev = "v${version}";
    hash = "sha256-xuypRhYDXAvYgvCusxa+ut8ITIuZxYkUa3fdu1eLSdA=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin for docker";
    homepage = "https://github.com/dj95/zj-docker";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
