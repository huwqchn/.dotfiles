{pkgs, ...}: let
  chooseTreeWasm = "file:${pkgs.my.zellijPlugins.zellij-choose-tree}/bin/zellij-choose-tree.wasm";
  launchChooseTree = {
    launchOrFocusPlugin = {
      _args = [chooseTreeWasm];
      _children = [
        {
          floating = true;
        }
        {
          move_to_focusd_tab = true;
        }
        {
          show_plugins = false;
        }
      ];
    };
  };
in {
  programs.zellij.setting.keybinds._children = [
    {
      tmux._children = [
        {
          bind = {
            _args = ["S"];
            _children = [
              launchChooseTree
              {SwitchToMode._args = ["locked"];}
            ];
          };
        }
      ];
    }
  ];
}
