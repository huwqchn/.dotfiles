# TODO: need to apply for all apps
{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.typer) enum attrs;
  inherit (lib.modules) mkIf;
  cfg = config.my.keyboard;
in {
  options.my.keyboard = {
    layout = mkOption {
      type = enum ["colemak" "qwerty"];
      default = "us";
      description = ''
        The keyboard layout to use. This is passed to setxkbmap.
      '';
    };
    bindings = mkOption {
      type = attrs;
      default = {
        a = "a";
        b = "b";
        c = "c";
        d = "d";
        e = "e";
        f = "f";
        g = "g";
        h = "h";
        i = "i";
        j = "j";
        k = "k";
        l = "l";
        m = "m";
        n = "n";
        o = "o";
        p = "p";
        q = "q";
        r = "r";
        s = "s";
        t = "t";
        u = "u";
        v = "v";
        w = "w";
        x = "x";
        y = "y";
        z = "z";
      };
      description = "my keyboard bindings";
    };
  };

  config = mkIf (cfg.layout == "colemak") {
    cfg.bindings = {
      h = "n";
      j = "e";
      k = "i";
      l = "o";
      i = "h";
      o = "l";
      n = "k";
      e = "j";
    };
  };
}
