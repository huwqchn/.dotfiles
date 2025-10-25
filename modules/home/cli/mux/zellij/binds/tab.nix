{config, ...}: {
  zellij.settings.keybinds._children = with config.my.keyboard.keys; [
    {
      shared_except = {
        _args = ["locked" "tab"];
        _children = [
          {
            bind = {
              _args = ["Ctrl" "t"];
              _children = [{SwitchToMode._args = ["tab"];}];
            };
          }
        ];
      };
    }
    {
      tab._children = [
        {
          bind = {
            _args = ["left"];
            _children = [{GoToPreviousTab = {};}];
          };
        }
        {
          bind = {
            _args = ["down"];
            _children = [{GoToNextTab = {};}];
          };
        }
        {
          bind = {
            _args = ["up"];
            _children = [{GoToPreviousTab = {};}];
          };
        }
        {
          bind = {
            _args = ["right"];
            _children = [{GoToNextTab = {};}];
          };
        }
        {
          bind = {
            _args = ["1"];
            _children = [
              {GoToTab._args = [1];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["2"];
            _children = [
              {GoToTab._args = [2];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["3"];
            _children = [
              {GoToTab._args = [3];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["4"];
            _children = [
              {GoToTab._args = [4];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["5"];
            _children = [
              {GoToTab._args = [5];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["6"];
            _children = [
              {GoToTab._args = [6];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["7"];
            _children = [
              {GoToTab._args = [7];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["8"];
            _children = [
              {GoToTab._args = [8];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["9"];
            _children = [
              {GoToTab._args = [9];}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["["];
            _children = [
              {BreakPaneLeft = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["]"];
            _children = [
              {BreakPaneRight = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["b"];
            _children = [
              {BreakPane = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = [h];
            _children = [{GoToPreviousTab = {};}];
          };
        }
        {
          bind = {
            _args = [j];
            _children = [{GoToNextTab = {};}];
          };
        }
        {
          bind = {
            _args = [k];
            _children = [{GoToPreviousTab = {};}];
          };
        }
        {
          bind = {
            _args = [l];
            _children = [{GoToNextTab = {};}];
          };
        }
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
            _args = ["c"];
            _children = [
              {SwitchToMode._args = ["renametab"];}
              {TabNameInput._args = ["0"];}
            ];
          };
        }
        {
          bind = {
            _args = ["s"];
            _children = [
              {ToggleActiveSyncTab = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["x"];
            _children = [
              {CloseTab = {};}
              {SwitchToMode._args = ["normal"];}
            ];
          };
        }
        {
          bind = {
            _args = ["Tab"];
            _children = [{ToggleTab = {};}];
          };
        }
      ];
    }
  ];
}
