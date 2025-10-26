{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-workspace";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "vdbulcke";
    repo = "zellij-workspace";
    rev = "v${version}";
    hash = "sha256-7KYdYCzCOq5nqjpzYESJCQi4UB+Aw7aBhJuHvVC9Kis=";
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
