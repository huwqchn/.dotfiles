{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "harpoon";
  version = "v0.1.0";

  src = fetchurl {
    url = "https://github.com/Nacho114/harpoon/releases/download/${version}/harpoon.wasm";
    sha256 = "00ln03gjpf6xdfq1d3z84pcvmyrk1n1ddi1nkfxsmnqxldyzinfa";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "Zellij plugin to quickly navigate your panes (clone of nvim's harpoon)";
    homepage = "https://github.com/Nacho114/harpoon";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
