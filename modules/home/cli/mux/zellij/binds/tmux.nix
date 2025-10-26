{config, ...}: {
  programs.zellij.settings.keybinds._children = with config.my.keyboard.keys; [
    {
      shared_except = {
        _args = ["tmux"];
        _children = [
          {
            bind = {
              _args = ["Ctrl a"];
              _children = [{SwitchToMode._args = ["Tmux"];}];
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
              _args = ["q"];
              _children = [{CloseFocus = {};} {SwitchToMode._args = ["normal"];}];
            };
          }
        ];
      };
    }
    {
      tmux._children = [
        # create panes
        {
          bind = {
            _args = [h];
            _children = [
              {NewPane._args = ["Left"];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = [j];
            _children = [
              {NewPane._args = ["Down"];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = [k];
            _children = [
              {NewPane._args = ["Up"];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = [l];
            _children = [
              {NewPane._args = ["Right"];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["s"];
            _children = [
              {SwitchToMode._args = ["session"];}
            ];
          };
        }
        {
          bind = {
            _args = ["m"];
            _children = [
              {SwitchToMode._args = ["move"];}
            ];
          };
        }
        {
          bind = {
            _args = ["Space"];
            _children = [
              {SwitchToMode._args = ["session"];}
            ];
          };
        }
        {
          bind = {
            _args = ["r"];
            _children = [
              {SwitchToMode._args = ["resize"];}
            ];
          };
        }
        {
          bind = {
            _args = ["f"];
            _children = [
              {TogglePaneEmbedOrFloating = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["F"];
            _children = [
              {ToggleFocusFullscreen = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        # Tab Operations
        {
          bind = {
            _args = ["t"];
            _children = [
              {NewTab = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["Tab"];
            _children = [
              {ToggleTab = {};}
            ];
          };
        }
        {
          bind = {
            _args = ["c"];
            _children = [
              {SwitchToMode._args = ["renametab"];}
              {TabNameInput._args = [0];}
            ];
          };
        }
        {
          bind = {
            _args = ["]"];
            _children = [
              {GoToNextTab = {};}
            ];
          };
        }
        {
          bind = {
            _args = ["["];
            _children = [
              {GoToPreviousTab = {};}
            ];
          };
        }
        # Tab Navigation 1..9
        {
          bind = {
            _args = ["1"];
            _children = [{GoToTab._args = [1];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["2"];
            _children = [{GoToTab._args = [2];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["3"];
            _children = [{GoToTab._args = [3];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["4"];
            _children = [{GoToTab._args = [4];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["5"];
            _children = [{GoToTab._args = [5];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["6"];
            _children = [{GoToTab._args = [6];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["7"];
            _children = [{GoToTab._args = [7];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["8"];
            _children = [{GoToTab._args = [8];} {SwitchToMode._args = ["normal"];}];
          };
        }
        {
          bind = {
            _args = ["9"];
            _children = [{GoToTab._args = [9];} {SwitchToMode._args = ["normal"];}];
          };
        }
      ];
    }
  ];
}
