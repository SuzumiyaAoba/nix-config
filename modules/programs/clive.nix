{ delib, pkgs, ... }:
delib.module {
  name = "programs.clive";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      (callPackage ../../pkgs/programs/clive.nix { })
    ];
  };
}
