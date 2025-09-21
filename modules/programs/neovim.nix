{ delib, pkgs, ... }:
delib.module {
  name = "programs.neovim";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      neovim
    ];
  };
}
