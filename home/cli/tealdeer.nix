{
  lib,
  config,
  ...
}:
lib.my.mkEnabledOption config "tealdeer" {
  enable = true;
  settings.updates = {
    auto_update = true;
    auto_update_interval_hours = 24;
  };
}
