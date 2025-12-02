{ delib, pkgs, ... }:
delib.module {
  name = "programs.golang";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      go
    ];
  };
}
