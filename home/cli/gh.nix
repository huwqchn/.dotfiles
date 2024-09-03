{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-copilot
      gh-markdown-preview
      gh-dash
      gh-notify
      gh-f
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
  # home.persistence = {
  #   "/persist/${config.home.homeDirectory}".files = [".config/gh/hosts.yml"];
  # };
}
