{ ... }:

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
    
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zdharma/fast-syntax-highlighting"; }
        { name = "agkozak/zsh-z"; }
        { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
      ];
    };

    initExtra = ''
      source "$HOME/.config/zsh/alias.zsh"
      source "$HOME/.config/zsh/keybinds.zsh"
    '';
  };

  home.file.".config/zsh".source = ./config;
}
