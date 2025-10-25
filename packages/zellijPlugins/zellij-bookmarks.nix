{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "zellij-bookmarks";
  src = fetchFromGitHub {
    owner = "yaroslavborbat";
    repo = "zellij-bookmarks";
    rev = "v0.2.0";
    hash = "sha256-1sznBLKuJM3+nkozlu/bEiglscKNpqnYRv9i6TJe+io=";
  };
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "Zellij plugin for creating, managing, and quickly inserting command bookmarks into the terminal.";
    homepage = "https://github.com/yaroslavborbat/zellij-bookmarks";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
