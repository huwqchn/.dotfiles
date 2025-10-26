{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-switch";
  version = "0.2.1";

  src = fetchurl {
    url = "https://github.com/mostafaqanbaryan/zellij-switch/releases/download/${version}/zellij-switch.wasm";
    sha256 = "1bi219dh9dfs1h7ifn4g5p8n6ini8ack1bfys5z36wzbzx0pw9gg";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin to switch between different programming language contexts.";
    homepage = "https://github.com/mostafaqanbaryan/zellij-switch";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
