{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-cb";
  src = fetchFromGitHub {
    owner = "ndavd";
    repo = "zellij-cb";
    rev = "c82517e112ee6ab30849922901d911c4104e5763";
    hash = "sha256-q64UK36bXTEd3xcMEDNw769Ya3axcn+gJAqsM2jL8gA=";
  };
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "Customizable compact bar plugin for Zellij";
    homepage = "https://github.com/ndavd/zellij-cb";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
