{pkgs, ...}: let
  chooseTreeWasm = "file:${pkgs.my.zellij-choose-tree}/bin/zellij-choose-tree.wasm";
  launchChooseTree = {
    LaunchOrFocusPlugin = {
      _args = [chooseTreeWasm];
      floating = true;
      move_to_focusd_tab = true;
      show_plugins = false;
    };
  };
in {
  programs.zellij.settings.keybinds._children = [
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
