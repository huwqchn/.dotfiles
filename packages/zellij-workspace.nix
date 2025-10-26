{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-workspace";
  version = "v0.3.0";

  src = fetchurl {
    url = "https://github.com/vdbulcke/zellij-workspace/releases/download/${version}/zellij-workspace.wasm";
    sha256 = "0wvb16dr1gnrf4bqdx1z6c7x7ka6zmgh98qg583haza9myjh87rx";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A Zellij plugin to easily navigate and create workspaces";
    homepage = "https://github.com/vdbulcke/zellij-workspace";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
