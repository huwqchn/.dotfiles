{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zjswitcher";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "WingsZeng";
    repo = "zjswitcher";
    rev = "v${version}";
    hash = "sha256-lACbFz3GP4E2kArdjTjpLdd1GpG9s7fo6mR0ltVO9Og=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin to switch sessions, tabs, panes.";
    homepage = "https://github.com/WingsZeng/zjswitcher";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
