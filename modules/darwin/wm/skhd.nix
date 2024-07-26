{
  config,
  myvars,
  mylib,
  ...
}: {
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile (mylib.relativeToConfig "skhd/skhdrc");
  };

  # custom log path for debugging
  launchd.user.agents.skhd.serviceConfig = let
    homeDir = config.users.users."${myvars.username}".home;
  in {
    StandardErrorPath = "${homeDir}/Library/Logs/skhd.stderr.log";
    StandardOutPath = "${homeDir}/Library/Logs/skhd.stdout.log";
  };
}
