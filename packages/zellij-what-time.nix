{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zellij-what-time";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "pirafrank";
    repo = "zellij-what-time";
    rev = version;
    hash = "sha256-6+uNUC22RL6jbe5lqQH3Bvp8XkzNBwVbNzlt+lBQ7Ys=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}.wasm
    chmod +x $out/bin/${pname}.wasm
  '';

  meta = with lib; {
    description = "A zellij plugin that shows the current time";
    homepage = "https://github.com/pirafrank/zellij-what-time";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
