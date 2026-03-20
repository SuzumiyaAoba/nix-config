{ delib, pkgs, ... }:
delib.module {
  name = "programs.atuin";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      atuin
    ];
  };
}
