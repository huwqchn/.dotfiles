{config, ...}: {
  programs.zellij.settings.keybinds._children = with config.my.keyboard.keys; [
    {
      shared_except = {
        _args = ["tmux" "locked"];
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
            _args = ["Space"];
            _children = [
              {SwitchToMode._args = ["session"];}
            ];
          };
        }
        # Tab Operations
        {
          bind = {
            _args = ["r"];
            _children = [
              {SwitchToMode._args = ["renametab"];}
              {TabNameInput._args = [0];}
            ];
          };
        }
      ];
    }
  ];
}
