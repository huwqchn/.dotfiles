# TODO: not test yet
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  clickgen, # 提供 ctgen
  cbmp, # 提供 cbmp 渲染工具
  variant ? "modern", # modern | modern-right | original | original-right
  baseColor ? "#000000", # 填充色，替换 SVG 中的 #00FF00
  outlineColor ? "#FFFFFF", # 描边色，替换 SVG 中的 #0000FF
  watchBackgroundColor ? "#000000", # 忙碌环背景，替换 SVG 中的 #FF0000
  colorName ? "classic", # 主题后缀
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
    }
