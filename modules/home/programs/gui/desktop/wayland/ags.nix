{
  #   inputs,
  #   pkgs,
  #   config,
  #   lib,
  #   ...
  # }: let
  #   inherit (lib.modules) mkIf;
  #   inherit (config.my) desktop;
  #   isWayland = desktop.type == "wayland";
  #   enable = desktop.enable && isWayland;
  # in {
  #   imports = [inputs.ags.homeManagerModules.default];
  #
  #   config = mkIf enable {
  #     programs.ags = {
  #       enable = true;
  #       configDir = lib.my.relativeToConfig "ags";
  #       extraPackages = with pkgs; [accountsservice];
  #     };
  #
  #     home = {
  #       packages = with pkgs; [
  #         bun
  #         dart-sass
  #         hyprpicker
  #         inputs.matugen.packages.${pkgs.system}.default
  #         swww
  #         brightnessctl
  #         slurp
  #         fortune
  #       ];
  #
  #       persistence."/persist${config.home.homeDirectory}".directories = [
  #         ".cache/ags"
  #         ".local/share/com.github.Aylur.ags"
  #       ];
  #     };
  #   };
}
