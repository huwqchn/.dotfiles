{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-cb";
  version = "v0.1.0";
  src =
    fetchurl {
      url = " https://github.com/ndavd/zellij-cb/releases/download/${version}/zellij-cb.w
asm";
      sha256 = "1lg9bww6s1afbynzxaj3dkkyhs9wzzp0yy5y5lqxlc6wv6q3nfw5";
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
