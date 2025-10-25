# TODO: not test yet
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  clickgen,
  cbmp,
  variant ? "modern",
  baseColor ? "#000000",
  outlineColor ? "#FFFFFF",
  watchBackgroundColor ? "#000000",
  colorName ? "classic",
}: let
  capitalize = str:
    lib.toUpper (builtins.substring 0 1 str)
    + builtins.substring 1 (builtins.stringLength str - 1) str;

  themeName = "Bibata-${capitalize variant}-${capitalize colorName}-Xcursor";
in
  assert builtins.elem variant ["modern" "modern-right" "original" "original-right"]
  || lib.throw "Invalid variant ${variant}, choose one of modern, modern-right, original, original-right";
    stdenvNoCC.mkDerivation rec {
      pname = "bibata-xcursor";
      version = "2.0.7";

      src = fetchFromGitHub {
        owner = "ful1e5";
        repo = "Bibata_Cursor";
        rev = "v${version}";
        sha256 = "kIKidw1vditpuxO1gVuZeUPdWBzkiksO/q2R/+DUdEc=";
      };

      nativeBuildInputs = [
        clickgen
        cbmp
      ];

      phases = ["unpackPhase" "configurePhase" "buildPhase" "installPhase"];

      unpackPhase = ''
        runHook preUnpack

        cp $src/configs/${
          if lib.hasSuffix "right" variant
          then "right"
          else "normal"
        }/x.build.toml config.toml

        mkdir cursors
        for cursor in $src/svg/${variant}/*; do
          cp -r $src/svg/${variant}/$(readlink $cursor) cursors
        done

        runHook postUnpack
      '';

      configurePhase = ''
        runHook preConfigure

        cat > render.json << EOF
        {
          "${themeName}": {
            "dir": "cursors/${variant}",
            "out": "bitmaps/${themeName}",
            "colors": [
              { "match": "#00FF00", "replace": "${baseColor}" },
              { "match": "#0000FF", "replace": "${outlineColor}" },
              { "match": "#FF0000", "replace": "${watchBackgroundColor}" }
            ]
          }
        }
        EOF

        runHook postConfigure
      '';

      buildPhase = ''
        runHook preBuild

        mkdir -p bitmaps
        cbmp render.json

        ctgen config.toml \
          -p x11 \
          -d bitmaps/${themeName} \
          -n "${themeName}" \
          -c "${themeName} XCursors"

        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/icons
        cp -r themes/theme_${themeName} $out/share/icons/${themeName}

        runHook postInstall
      '';

      meta.platforms = lib.platforms.linux;
    }
