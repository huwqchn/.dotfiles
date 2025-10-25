{config, ...}: {
  programs.zellij.settings.keybinds._children = with config.my.keyboard.keys; [
    {
      shared_except = {
        _args = ["locked" "pane"];
        _children = [
          {
            bind = {
              _args = ["Ctrl" "p"];
              _children = [{SwitchToMode._args = ["pane"];}];
            };
          }
        ];
      };
    }
    {
      pane._children = [
        {
          bind = {
            _args = ["p"];
            _children = [
              {TogglePanePinned = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = [h];
            _children = [{MoveFocus._args = ["Left"];}];
          };
        }
        {
          bind = {
            _args = [j];
            _children = [{MoveFocus._args = ["Down"];}];
          };
        }
        {
          bind = {
            _args = [k];
            _children = [{MoveFocus._args = ["Up"];}];
          };
        }
        {
          bind = {
            _args = [l];
            _children = [{MoveFocus._args = ["Right"];}];
          };
        }
        {
          bind = {
            _args = ["left"];
            _children = [{MoveFocus._args = ["left"];}];
          };
        }
        {
          bind = {
            _args = ["down"];
            _children = [{MoveFocus._args = ["down"];}];
          };
        }
        {
          bind = {
            _args = ["up"];
            _children = [{MoveFocus._args = ["up"];}];
          };
        }
        {
          bind = {
            _args = ["right"];
            _children = [{MoveFocus._args = ["right"];}];
          };
        }
        {
          bind = {
            _args = ["c"];
            _children = [{SwitchToMode._args = ["renamePane"];} {PaneNameInput._args = ["0"];}];
          };
        }
        {
          bind = {
            _args = [H];
            _children = [{NewPane._args = ["Left"];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = [J];
            _children = [{NewPane._args = ["Down"];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = [K];
            _children = [{NewPane._args = ["Up"];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = [L];
            _children = [{NewPane._args = ["Right"];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["F"];
            _children = [{TogglePaneEmbedOrFloating = {};} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["f"];
            _children = [
              {ToggleFocusFullscreen = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["s"];
            _children = [
              {NewPane._args = ["stacked"];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["w"];
            _children = [
              {ToggleFloatingPanes = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["z"];
            _children = [
              {ToggleFloatingPanes = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
      ];
    }
  ];
}
