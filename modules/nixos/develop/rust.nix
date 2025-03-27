# modules/dev/rust.nix --- https://rust-lang.org
#
# Oh Rust. The light of my life, fire of my loins. Years of C++ has conditioned
# me to believe there was no hope left, but the gods have heard us. Sure, you're
# not going to replace C/C++. Sure, your starlight popularity has been
# overblown. Sure, macros aren't namespaced, cargo bypasses crates.io, and there
# is no formal proof of your claims for safety, but who said you have to solve
# all the world's problems to be wonderful?
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.develop.rust;
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.my.develop.rust = {
    enable = mkEnableOption "Rust development environment";
    xdg.enable = mkEnableOption "Rust XDG environment variables";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hm.home.packages = [pkgs.rustup];
      environment.shellAliases = {
        rs = "rustc";
        rsp = "rustup";
        ca = "cargo";
      };
    })

    (mkIf cfg.xdg.enable {
      environment.variables = rec {
        RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
        CARGO_HOME = "$XDG_DATA_HOME/cargo";
        PATH = ["${CARGO_HOME}/bin"];
      };
    })
  ];
}
