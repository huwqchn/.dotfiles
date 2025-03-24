{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./pipewire
    ./wireplum

    ./pulseaudio.nix
    ./rtkit.nix
  ];

  options.my.machine.hasSound = mkEnableOption "Whether the system has sound";
}
