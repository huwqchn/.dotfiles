{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
  ];
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "hu wenqiang" ];
  };
}
