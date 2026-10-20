{ delib, pkgs, ... }:
delib.module {
  name = "programs.neovim";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    xdg.configFile."nvim".source = ../../../home/.config/nvim;

    home.packages = with pkgs; [
      neovim
      neovide
    ];
  };
}
