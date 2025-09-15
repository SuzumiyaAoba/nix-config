{ delib, pkgs, ... }:
delib.module {
  name = "programs.claude-monitor";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      (callPackage ../../pkgs/programs/claude-monitor.nix { })
    ];
  };
}


