{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    _1password
    _1password-gui
  ];
  # programs._1password.enable = true;
  # programs._1password-gui = {
  #  enable = true;
  #  polkitPolicyOwners = [ "hu wenqiang" ];
  #};
}
