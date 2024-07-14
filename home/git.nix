let 
  name = "Johnson Hu";
  email = "huwqchn@gmail.com";
in {
  programs.git = {
    enable = true;
    lfs.enable = true;
    
    userName = name;
    userEmail = email;

    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = "huwqchn";
      push.autoSetupRemote = true;
    };
  };
}
