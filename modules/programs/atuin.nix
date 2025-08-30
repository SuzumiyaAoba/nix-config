{ delib, pkgs, ... }:
delib.module {
  name = "programs.atsuin";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      atuin
    ];
  };
}
