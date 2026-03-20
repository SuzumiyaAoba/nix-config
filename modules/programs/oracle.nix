{ delib, pkgs, ... }:
delib.module {
  name = "programs.oracle";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      oracle-instantclient
    ];
  };
}
