{
  nix = {
    settings.auto-optimise-store = true;
    daemonIOSchedPriority = 5;
    daemonCPUSchedPolicy = "batch";
    gc.dates = "weekly";
  };
}
