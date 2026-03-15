{ delib, pkgs, ... }:
delib.module {
  name = "programs.jetbrains";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages =
      (with pkgs; [
        jetbrains.datagrip
        jetbrains.rust-rover
        jetbrains.goland
      ])
      ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
        pkgs.jetbrains.idea
        pkgs.jetbrains.rider
      ];
  };
}
