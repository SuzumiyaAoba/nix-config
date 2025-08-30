{ delib, pkgs, ... }:
delib.module {
  name = "programs.clive";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      (callPackage ../../pkgs/programs/clive.nix {})
    ];
  };
}
