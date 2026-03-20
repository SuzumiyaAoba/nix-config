{ delib, pkgs, ... }:
delib.module {
  name = "programs.neovim";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      neovim
      neovide
    ];
  };
}
