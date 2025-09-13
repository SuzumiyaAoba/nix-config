{ delib, pkgs, ... }:
delib.module {
  name = "homebrew.karabiner";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      karabiner-elements
    ];
  };
}
