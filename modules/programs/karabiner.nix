{ delib, pkgs, ... }:
delib.module {
  name = "homebrew.karabiner";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      karabiner-elements
    ];
  };
}
