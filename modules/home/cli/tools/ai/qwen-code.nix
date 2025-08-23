{pkgs, ...}: {
  home.packages = with pkgs; [
    qwen-code
  ];
}
