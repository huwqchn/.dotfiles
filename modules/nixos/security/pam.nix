{
  config,
  lib,
  ...
}:
with lib; {
  services.gnome.gnome-keyring.enable = mkDefault config.my.desktop.enable;
  security = {
    pam = {
      # fix "too many files open" errors while writing a lot of data at once
      # (e.g. when building a large package)
      # if this, somehow, doesn't meet your requirements you may just bump the numbers up
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services = let
        ttyAudit = {
          enable = true;
          enablePattern = "*";
        };
        fprintAuth = config.services.fprintd.enable;
        enableGnomeKeyring = mkDefault config.my.desktop.enable;
      in {
        # Allow screen lockers such as Swaylock or gtklock) to also unlock the screen.
        swaylock.text = "auth include login";
        gtklock.text = "auth include login";
        hyprlock.text = "auth include login";
        greetd.text = "auto include login";

        login = {
          inherit ttyAudit fprintAuth enableGnomeKeyring;
          setLoginUid = true;
        };

        sshd = {
          inherit ttyAudit;
          setLoginUid = true;
        };

        sudo = {
          inherit ttyAudit;
          setLoginUid = true;
        };
      };
    };
  };
}
