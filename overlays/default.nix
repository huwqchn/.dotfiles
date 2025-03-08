_: [
  (_final: prev: {
    vimPlugins =
      prev.vimPlugins
      # Remove when vimPlugins.LazyVim updated
      // {
        LazyVim = prev.vimPlugins.LazyVim.overrideAttrs (old: rec {
          version = "14.14.0";
          src = old.src.override {
            rev = "3f034d0a7f58031123300309f2efd3bb0356ee21";
            sha256 = "sha256-1q8c2M/FZxYg4TiXe9PK6JdR4wKBgPbxRt40biIEBaY=";
          };
        });
      };
  })
]
