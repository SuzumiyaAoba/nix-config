{ delib, pkgs, ... }:
delib.module {
  name = "programs.rectangle";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      rectangle
    ];
  };
}
