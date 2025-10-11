{ delib, pkgs, ... }:
delib.module {
  name = "programs.antidote";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      antidote
    ];

    programs.zsh = {
      initContent = ''
        # Initialize antidote plugin manager
        if [[ -f "${pkgs.antidote}/share/antidote/antidote.zsh" ]]; then
          source "${pkgs.antidote}/share/antidote/antidote.zsh"

          # Create writable antidote directory in user's data directory
          mkdir -p "$HOME/.local/share/antidote"

          # Copy plugins file to writable location if it doesn't exist or is older
          if [[ ! -f "$HOME/.local/share/antidote/zsh_plugins.txt" ]] || [[ "$HOME/.config/antidote/zsh_plugins.txt" -nt "$HOME/.local/share/antidote/zsh_plugins.txt" ]]; then
            cp "$HOME/.config/antidote/zsh_plugins.txt" "$HOME/.local/share/antidote/zsh_plugins.txt"
          fi

          # Load plugins from writable location
          antidote load "$HOME/.local/share/antidote/zsh_plugins.txt"
        fi
      '';
    };
  };
}