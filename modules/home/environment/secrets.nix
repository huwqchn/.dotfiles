{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops.homeManagerModules.sops
    ../../common/secrets.nix
  ];

  # some security tools
  home.packages = with pkgs; [
    rage
    age
    sops
    rclone
  ];
}
