{inputs, ...}: {
  flake.overlays = let
    # Export overlays coming from inputs directly
    emacs = inputs.emacs-overlay.overlay;
    treesitter = inputs.nvim-treesitter-main.overlays.default;

    # Your overlay that modifies vimPlugins
    vimTweaks = _final: prev: {
      vimPlugins = prev.vimPlugins.extend (f: p: {
        nvim-treesitter = p.nvim-treesitter.withAllGrammars;
        nvim-treesitter-textobjects =
          p.nvim-treesitter-textobjects.overrideAttrs {dependencies = [f.nvim-treesitter];};

        project-nvim = prev.vimUtils.buildVimPlugin {
          pname = "project.nvim";
          version = "2025-10-18";
          src = prev.fetchFromGitHub {
            owner = "ahmedkhalf";
            repo = "project.nvim";
            rev = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb";
            hash = "sha256-avV3wMiDbraxW4mqlEsKy0oeewaRj9Q33K8NzWoaptU=";
          };
        };

        venv-selector-nvim = prev.vimUtils.buildVimPlugin {
          pname = "venv-selector.nvim";
          version = "2025-10-18";
          src = prev.fetchFromGitHub {
            owner = "linux-cultist";
            repo = "venv-selector.nvim";
            rev = "7fff64b5b1455207b9a9fd2ae8697cf9ac0b2a2d";
            hash = "sha256-m165YyY8VX0YQ5v6vxDJp4avDRrxByZQY+uMNkubggo=";
          };
        };
      });
    };

    # Your overlay that modifies qt6Packages
    qt6FcitxNoCfgtool = _final: prev: {
      qt6Packages = prev.qt6Packages.overrideScope (_qt6final: qt6prev: {
        fcitx5-with-addons = qt6prev.fcitx5-with-addons.override {withConfigtool = false;};
      });
    };
  in {
    # Export named overlays for external/internal use
    inherit emacs treesitter vimTweaks qt6FcitxNoCfgtool;
  };
}
