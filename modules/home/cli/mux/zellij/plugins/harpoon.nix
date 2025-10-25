{pkgs, ...}: let
  harpoonWasm = "file:${pkgs.my.zellijPlugins.zellij-harpoon}/bin/zellij-harpoon.wasm";
  launchHarpoon = {
    launchOrFocusPlugin = {
      _args = [harpoonWasm];
      _children = [
        {
          floating = true;
        }
        {
          move_to_focusd_tab = true;
        }
      ];
    };
  };
in {
  programs.zellij.setting = {
    plugins.harpoon._props.location = harpoonWasm;
    keybinds._children = [
      {
        shared_except = {
          _args = ["locked" "tmux" "pane"];
          _children = [
            {
              bind = {
                _args = ["Alt" "a"];
                _children = [
                  launchHarpoon
                ];
              };
            }
          ];
        };
      }
      {
        shared_among = {
          _args = ["tmux" "pane"];
          _children = [
            {
              bind = {
                _args = ["a"];
                _children = [
                  launchHarpoon
                ];
              };
            }
          ];
        };
      }
    ];
  };
}
