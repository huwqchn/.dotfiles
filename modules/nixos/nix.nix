{
  nix = {
    daemonIOSchedPriority = 5;
    daemonCPUSchedPolicy = "batch";
    gc.dates = "weekly";
  };
}
