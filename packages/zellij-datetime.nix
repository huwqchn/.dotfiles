{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-datetime";
  version = "v0.21.0";
  src = fetchurl {
    url = "https://github.com/h1romas4/zellij-datetime/releases/download/${version}/zellij-datetime.wasm";
    sha256 = "0h8hmi5l1xbx1khcns7m4xvsi6gjyd0p1rnmcdf8hys5p7f22lx1";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "This plugin adds a date and time pane to [Zellij](https://zellij.dev/), a terminal workspace.";
    homepage = "https://github.com/h1romas4/zellij-datetime";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
