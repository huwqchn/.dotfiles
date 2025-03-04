{
  lib,
  config,
  ...
}:
lib.my.mkEnabledModule config "fzf" {
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--cycle"
      "--layout=reverse"
      "--height 60%"
      "--ansi"
      "--preview-window=right:70%"
      "--bind=ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-x:jump"
      "--bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up"
      "--bind=ctrl-a:beginning-of-line,ctrl-e:end-of-line"
      "--bind=ctrl-e:down,ctrl-i:up"
    ];
  };
}
