{pkgs, ...}: let
  roomWasm = "file:${pkgs.my.room}/bin/room.wasm";
  launchRoom = {
    launchOrFocusPlugin = {
      _args = [roomWasm];
      _children = [
        {
          floating = true;
        }
        {
          ignore_case = true;
        }
        {
          quick_jump = true;
        }
      ];
    };
  };
in {
  programs.zellij.setting = {
    plugins.harpoon._props.location = roomWasm;
    keybinds._children = [
      {
        shared_except = {
          _args = ["locked"];
          _children = [
            {
              bind = {
                _args = ["Alt" "r"];
                _children = [
                  launchRoom
                ];
              };
            }
          ];
        };
      }
    ];
  };
}
