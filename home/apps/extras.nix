{pkgs, ...}: {
  home.packages = with pkgs; [
    # instant messaging
    telegram-desktop
    discord

    # note taking
    obsidian
  ];
}
