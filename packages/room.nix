{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "room";
  version = "v1.2.0";
  src = fetchurl {
    url = "https://github.com/rvcas/room/releases/download/${version}/room.wasm";
    sha256 = "0k5fy3svjvifsgp0kdvqdx9m9rzrql9cwq6hbvxdgklfnczqz8dp";
  };
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A Zellij plugin for quickly searching and switching tabs";
    homepage = "https://github.com/rvcas/room";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
