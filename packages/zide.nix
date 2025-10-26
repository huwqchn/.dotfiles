{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation rec {
  pname = "zide";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "josephschmitt";
    repo = "zide";
    rev = "v${version}";
    hash = "sha256-CqpqkGdsEGZ5IeuZD87ONlN68MkTgip9SNnsxzQ1YGk=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p "$out"
    cp -R . "$out/"
  '';
}
