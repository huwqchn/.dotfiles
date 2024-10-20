{
  myvars,
  config,
  ...
}: let
  cfgUser = config.users.users."${myvars.userName}";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users = {
    # Don't allow mutation of users outside the config.
    mutableUsers = false;

    groups = {
      "${myvars.userName}" = {};
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
      "${myvars.userName}" = {
        inherit (myvars) initialHashedPassword;
        home = "/home/${myvars.userName}";
        isNormalUser = true;
        extraGroups =
          [
            "wheel"
          ]
          ++ ifTheyExist [
            myvars.userName
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
