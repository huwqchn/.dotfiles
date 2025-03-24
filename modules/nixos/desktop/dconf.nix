{
  config,
  pkgs,
  ...
}: let
  cfg = config.my.desktop;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    programs = {
      # The OpenSSH agent remembers private keys for you
      # so that you don’t have to type in passphrases every time you make an SSH connection.
      # Use `ssh-add` to add a key to the agent.
      # ssh.startAgent = true;
      # dconf is a low-level configuration system.
      dconf.enable = true;
    };
  };
}
