{
  python3Packages,
  fetchPypi,
  ...
}:
python3Packages.buildPythonApplication rec {
  pname = "conventional_pre_commit";
  version = "3.4.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-byr6yIzr9Qdz4O8QZ7yrRpZuUS3+wRBclD1bkpvjLoY=";
  };

  doCheck = false;
  pyproject = true;

  build-system = with python3Packages; [
    setuptools
    setuptools-scm
    wheel
  ];
}
