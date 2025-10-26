{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-jump-list";
  version = "v0.1.0";

  src = fetchurl {
    url = "https://github.com/blank2121/zellij-jump-list/releases/download/Latest/zellij-jump-list.wasm";
    sha256 = "0p17aanprmw71r67hliyk17q825mn86pwhgslagflh7vvgr4w8cm";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin that provides a jump list like feature.";
    homepage = "https://github.com/blank2121/zellij-jump-list";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
