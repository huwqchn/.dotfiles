{
  config,
  mylib,
  ...
}: {
  home-manager.users."${config.my.name}".imports = [
    mylib.relativeToRoot
    "home"
  ];
}
