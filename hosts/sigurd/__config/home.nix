{ home-manager, mylib, ... }: {
  home-manager.users."${myvars.userName}".imports = [
    mylib.relativeToRoot "home"
  ];
}