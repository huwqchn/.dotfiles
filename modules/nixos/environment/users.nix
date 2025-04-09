{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.my) name home;
  cfgUser = config.users.users."${config.my.name}";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  group = lib.my.ldTernary pkgs "users" "admin";
in {
  users = {
    # Don't allow mutation of users outside the config.
    mutableUsers = false;

    # set user's default shell system-wide
    defaultUserShell = pkgs.bashInteractive;

    groups = {
      "${name}" = {};
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
      "${name}" = {
        inherit (config.my) initialHashedPassword;
        inherit group;
        isNormalUser = true;
        extraGroups =
          [
            "wheel"
          ]
          ++ ifTheyExist [
            name
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

  # cause we need ~/.ssh to be created before agenix sevices running
  systemd.tmpfiles.rules = [
    "d ${home}/.ssh 0750 ${name} ${group} -"
    "d ${home}/.ssh/sockets 0750 ${name} ${group} -"
  ];
}
