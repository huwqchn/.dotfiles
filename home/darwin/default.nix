{
  mylib,
  myvars,
  ...
}: {
  home.homeDirectory = "/User/${myvars.userName}";
  imports =
    (mylib.scanPaths ./.)
    ++ [
      ../base

    ];

}
