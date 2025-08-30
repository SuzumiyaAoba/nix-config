{ delib, pkgs, ... }:
delib.module {
  name = "programs.hexyl";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      hexyl
    ];
  };
}
