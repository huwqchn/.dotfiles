{
  pkgs,
  mylib,
  ...
}: {
  xdg.configFile = {
    "fcitx5/profile" = {
      source = mylib.relativeToConfig "fcitx5/profile";
      force = true;
    };
    "fcitx5/conf/classicui.conf".source = mylib.relativeToConfig "fcitx5/conf/classicui.conf";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addon = with pkgs; [
      # for flypy chinese input method
      fcitx5-rime
      # needed enable rime using configtool after installed
      fcitx5-configtool
      fcitx5-chinese-addons
      # gkt im module
      fcitx5-gtk
      # qt lib
      fcitx5-qt
      # pinyin dictionary
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-sougou
      # material color theme
      fcitx5-material-color
    ];
  };
}
