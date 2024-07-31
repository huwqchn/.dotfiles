{ myvars, ... }: {
  home.homeDirectory = "/User/${myvars.userName}";
}
