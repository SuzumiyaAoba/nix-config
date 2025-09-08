{ delib, pkgs, ... }:
delib.module {
  name = "programs.aider";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      aider-chat
    ];
  };
}
