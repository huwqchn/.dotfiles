{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "zellij-jump-list";

  src = fetchFromGitHub {
    owner = "blank2121";
    repo = "zellij-jump-list";
    rev = "71695202d2b7ecd0caaa27708ab8a257da675a93";
    hash = "sha256-VT/Tyc701g1eHFvBNshqC2g4JaguLtaYH0L18PFOKRU=";
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
