{
  nix = {
    settings.auto-optimize-store = true;
    daemonIOSchedPriority = "batch";
    daemonCPUSchedPolicy = 5;
    gc.dates = "weekly";
  };
}
