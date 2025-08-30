{ delib, pkgs, ... }:
delib.module {
  name = "programs.emacs-lsp-booster";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      emacs-lsp-booster
    ];
  };
}
