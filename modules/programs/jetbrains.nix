{ delib, pkgs, ... }:
delib.module {
  name = "programs.jetbrains";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      jetbrains.idea-ultimate
      jetbrains.datagrip
      jetbrains.rider
      jetbrains.rust-rover
      jetbrains.goland
    ];
  };
}
