{
  nix = {
    settings.auto-optimize-store = true;
    daemonIOSchedPriority = 5;
    daemonCPUSchedPolicy = "batch";
    gc.dates = "weekly";
  };
}
