{
  # systemd DNS resolver daemon
  services.resolved.enable = true;

  systemd = {
    # allow for the system to boot without waiting for the network interfaces are online
    network.wait-online.enable = false;

    services = {
      # https://github.com/systemd/systemd/blob/e1b45a756f71deac8c1aa9a008bd0dab47f64777/NEWS#L13
      NetworkManager-wait-online.enable = false;

      # disable networkd and resolved from being restarted on configuration changes
      # also prevents failures from services that are restarted instead of stopped
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };
}
