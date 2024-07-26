{
  config,
  myvars,
  mylib,
  ...
}: let
  homeDir = config.users.users."${myvars.userName}".home;
in {
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ya/yabai/package.nix
  services.yabai = {
    enable = true;

    # Whether to enable yabai's scripting-addition.
    # SIP must be disabled for this to work.
    # https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
    enableScriptingAddition = true;
    # config = {};
    extraConfig = builtins.readFile (mylib.relativeToConfig "yabai/yabairc");
  };

  # custom log path for debugging
  launchd.user.agents.yabai.serviceConfig = {
    StandardErrorPath = "${homeDir}/Library/Logs/yabai.stderr.log";
    StandardOutPath = "${homeDir}/Library/Logs/yabai.stdout.log";
  };
}
