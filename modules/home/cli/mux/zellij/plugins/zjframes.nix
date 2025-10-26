{pkgs, ...}: let
  zjframesWasm = "${pkgs.zjstatus}/bin/zjframes.wasm";
in {
  programs.zellij.settings.load_plugins._children = [
    {
      "file:${zjframesWasm}" = {
        _props = {
          hide_frame_for_single_pane = true;
          hide_frame_except_for_search = true;
          hide_frame_except_for_scroll = true;
          hide_frame_except_for_fullscreen = true;
        };
      };
    }
  ];
}
