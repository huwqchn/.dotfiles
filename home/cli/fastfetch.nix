{
  config,
  lib,
  ...
}: let
  shellAliases = {"fetch" = "fastfetch";};
  inherit (config.programs) kitty;
  cfg = config.my.fastfetch;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };
  config = mkIf cfg.enable {
    home = {inherit shellAliases;};
    # programs.nushell = {inherit shellAliases;};
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          type =
            if kitty.enable
            then "kitty-direct"
            else "chafa";
          # width = 60;
          height = 18;
          printRemaining = false;
          source = "$(find $HOME/.config/fastfetch/pngs/ -name '*.png' | sort -R | head -n 1)";
          chafa = {symbols = "vhalf";};
          padding = {
            top = 1;
            left = 2;
            right = 2;
            bottom = 0;
          };
        };
        display = {
          separator = " : ";
          # keyWidth = 15;
        };
        modules = [
          {
            type = "custom";
            format = " 󰊠  コンピューター";
          }
          {
            type = "custom";
            format = "┌──────────────────────────────────────────┐";
          }
          {
            type = "os";
            key = "   OS";
            keyColor = "red";
          }
          {
            type = "kernel";
            key = "   Kernel";
            keyColor = "red";
          }
          {
            type = "packages";
            key = "  󰏓 Packages";
            keyColor = "green";
          }
          {
            type = "display";
            key = "  󰍹 Display";
            keyColor = "green";
          }
          {
            type = "wm";
            key = "   WM";
            keyColor = "yellow";
          }
          {
            type = "terminal";
            key = "   Terminal";
            keyColor = "yellow";
          }
          {
            type = "custom";
            format = "└──────────────────────────────────────────┘";
          }
          "break"
          {
            type = "title";
            key = "  ";
          }
          {
            type = "custom";
            format = "┌──────────────────────────────────────────┐";
          }
          {
            type = "cpu";
            format = "{1}";
            key = "  󰍛 CPU";
            keyColor = "blue";
          }
          {
            type = "gpu";
            format = "{2}";
            key = "   GPU";
            keyColor = "blue";
          }
          {
            type = "gpu";
            format = "{3}";
            key = "   GPU Driver";
            keyColor = "magenta";
          }
          {
            type = "memory";
            key = "   Memory";
            keyColor = "magenta";
          }
          {
            type = "command";
            key = "  󱦟 OS Age ";
            keyColor = "31";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            type = "uptime";
            key = "  󱫐 Uptime ";
            keyColor = "red";
          }
          {
            type = "custom";
            format = "└──────────────────────────────────────────┘";
          }
          {
            type = "colors";
            paddingLeft = 2;
            symbol = "circle";
          }
          "break"
        ];
      };
    };
    xdg.configFile."fastfetch/pngs".source =
      lib.my.relativeToConfig "fastfetch/pngs";
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".cache/fastfetch"];
    };
  };
}
