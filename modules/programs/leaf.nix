{ delib, pkgs, ... }:
delib.module {
  name = "programs.leaf";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      (pkgs.callPackage ../../pkgs/programs/leaf.nix { })
    ];
  };
}
