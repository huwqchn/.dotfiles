{
  config,
  pkgs,
  ...
}: let
  cfgUser = config.users.users."${config.my.name}";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users = {
    # Don't allow mutation of users outside the config.
    mutableUsers = false;

    # set user's default shell system-wide
    defaultUserShell = pkgs.bashInteractive;

    groups = {
      "${config.my.name}" = {};
      docker = {};
      wireshark = {};
      # for android platform tools's udev rules
      adbusers = {};
      dialout = {};
      # for openocd (embedded system development)
      plugdev = {};
      # misc
      uinput = {};
    };
    users = {
      "${config.my.name}" = {
        inherit (config.my) initialHashedPassword;
        isNormalUser = true;
        extraGroups =
          [
            "wheel"
          ]
          ++ ifTheyExist [
            config.my.name
            "users"
            "git"
            "networkmanager"
            "docker"
            "wireshark"
            "adbusers"
            "libvirtd"
          ];
      };
      # root's ssh key are mainly used for remote deployment
      root = {
        inherit (cfgUser) initialHashedPassword;
        openssh.authorizedKeys.keys = cfgUser.openssh.authorizedKeys.keys;
      };
    };
  };
}
