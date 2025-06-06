{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) rgba;
  inherit (config.my.theme.colorscheme) palette;
  cfg = config.my.theme.tokyonight;
in {
  config = mkIf cfg.enable {
    programs.anyrun.extraCss = with palette; ''
      * {
        all: unset;
        font-size: 1.2rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match.activatable {
        border-radius: 8px;
        margin: 4px 0;
        padding: 4px;
        /* transition: 100ms ease-out; */
      }
      #match.activatable:first-child {
        margin-top: 12px;
      }
      #match.activatable:last-child {
        margin-bottom: 0;
      }

      #match:hover {
        background: ${rgba bg_popup 0.05};
      }
      #match:selected {
        background: ${rgba bg_visual 0.1};
      }

      #entry {
        background: ${rgba info 0.05};
        border: 1px solid ${rgba border_highlight 0.1};
        border-radius: 8px;
        padding: 4px 8px;
      }

      box#main {
        background: ${rgba bg 0.5};
        box-shadow:
          inset 0 0 0 1px ${rgba bg_dark 0.1},
          0 30px 30px 15px ${rgba bright_black 0.5};
        border-radius: 20px;
        padding: 12px;
      }
    '';
  };
}
