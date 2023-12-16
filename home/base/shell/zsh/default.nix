{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    history = {
      size = 100000;
      path = "$HOME/.zsh_history";
      save = 1000000;

      share = true;

      ignoreAllDups = true;
      ignoreSpace = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    enableAutosuggestions = true;

    syntaxHighlighting = {
      enable = true;
    };
    autocd = true;

    initExtra = ''
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      source "''${ZINIT_HOME}/zinit.zsh"

      source "$HOME/.config/zsh/alias.zsh"
      source "$HOME/.config/zsh/keybinds.zsh"
    '';
  };

  home.file.".config/zsh".source = ./config;
}
