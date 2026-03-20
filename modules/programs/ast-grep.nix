{ delib, pkgs, ... }:
delib.module {
  name = "programs.ast-grep";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      (callPackage ../../pkgs/programs/ast-grep.nix { })
    ];
  };
}
