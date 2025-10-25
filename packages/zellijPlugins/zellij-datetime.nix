{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "zellij-datetime";
  src = fetchFromGitHub {
    owner = "h1romas4";
    repo = "zellij-datetime";
    rev = "v0.21.0";
    hash = "sha256-hMkzhP+4r6PLeJBOr6AZlvC+qn2HOiwQYdakOr8bkHE=";
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
