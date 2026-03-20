{ delib, pkgs, ... }:
delib.module {
  name = "programs.hexyl";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      hexyl
    ];
  };
}
