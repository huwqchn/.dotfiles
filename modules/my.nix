{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.my = {
    name = mkOption {
      type = types.str;
      default = "johnson";
      description = "The user name";
    };
    fullName = mkOption {
      type = types.str;
      default = "Johnson Hu";
      description = "The user full name";
    };
    email = mkOption {
      type = types.str;
      default = "johnson.wq.hu@gmail.com";
      description = "The user email";
    };
    theme = mkOption {
      type = types.str;
      default = "tokyonight-moon";
      description = "The theme of the system";
    };
    wallpaper = mkOption {
      type = types.str;
      default = "wallpapers/1.jpg";
      description = "The wallpaper of the system";
    };
    initialHashedPassword = mkOption {
      type = types.singleLineStr;
      default = "$y$j9T$UtvejDe22fK.4ok7ZyI1Y/$.vc/kQ3hRFbb2ntOCQQna3CcWWP6dxwtEAE1O9bWcO8";
      description = "The hashed password of the user";
    };
  };
}
