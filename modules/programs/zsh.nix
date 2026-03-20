{ delib, pkgs, ... }:
delib.module {
  name = "programs.zsh";

  options = delib.singleEnableOption true;

  home.ifEnabled =
    { myconfig, ... }:
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

        autocd = true;

        initContent = ''
          # zmodload zsh/zprof

          if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
          fi

          source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
          zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
          zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

          source "$HOME/.config/zsh/init.zsh"

          export LOMBOK_JAR_PATH=${pkgs.lombok}/share/java/lombok.jar

          POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
          if [[ "$TERM_PROGRAM" == "vscode" || -n $CURSOR_TRACE_ID ]]; then
            ZSH_THEME=""
          else
            ZSH_THEME="powerlevel10k/powerlevel10k"
          fi

          if [[ "$TERM_PROGRAM" == "vscode" || -n $CURSOR_TRACE_ID ]]; then
            PROMPT='%n@%m:%~%# '
            RPROMPT=""
          else
            [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          fi
        '';
      };
    };
}
