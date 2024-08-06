{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    userSettings = {};
    package =
      (pkgs.vscode.override
        {
          isInsiders = true;
          # https://wiki.archlinux.org/title/Wayland#Electron
          commandLineArgs = [
            "--ozone-platform-hint=auto"
            "--ozone-platform=wayland"
            # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
            # (only supported by chromium/chrome at this time, not electron)
            "--gtk-version=4"
            # make it use text-input-v1, which works for kwin 5.27 and weston
            "--enable-wayland-ime"

            # TODO: fix https://github.com/microsoft/vscode/issues/187436
            # still not works...
            "--password-store=gnome" # use gnome-keyring as password store
          ];
        })
      .overrideAttrs (oldAttrs: rec {
        # Use VSCode Insiders to fix crash: https://github.com/NixOS/nixpkgs/issues/246509
        src = builtins.fetchTarball {
          url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
          sha256 = "0k2sh7rb6mrx9d6bkk2744ry4g17d13xpnhcisk4akl4x7dn6a83";
        };
        version = "latest";
      });
  }
}