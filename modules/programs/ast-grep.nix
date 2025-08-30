{ delib, pkgs, ... }:
delib.module {
  name = "programs.ast-grep";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      ast-grep
    ];
  };
}
