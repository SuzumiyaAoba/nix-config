{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.zsh";

  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    {
      home.sessionPath = lib.optionals pkgs.stdenv.isDarwin [
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
      ];

      home.sessionVariables = lib.optionalAttrs pkgs.stdenv.isDarwin {
        HOMEBREW_PREFIX = "/opt/homebrew";
        HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
        HOMEBREW_REPOSITORY = "/opt/homebrew";
      };

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

        completionInit = ''
          autoload -U compinit

          typeset zcompdump="''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-''${HOST}-''${ZSH_VERSION}"
          mkdir -p "''${zcompdump:h}"

          if [[ -f "$zcompdump" ]]; then
            compinit -C -d "$zcompdump"
          else
            compinit -d "$zcompdump"
          fi
        '';

        initContent = lib.mkMerge [
          (lib.mkOrder 550 (
            lib.optionalString pkgs.stdenv.isDarwin ''
              if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
                fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
              fi

              if [[ -d /opt/homebrew/share/man ]]; then
                manpath=(/opt/homebrew/share/man $manpath)
              fi

              if [[ -d /opt/homebrew/share/info ]]; then
                INFOPATH="/opt/homebrew/share/info''${INFOPATH:+:''${INFOPATH}}"
              fi
            ''
          ))
          ''
            # zmodload zsh/zprof

            source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
            zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
            zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

            source "$HOME/.config/zsh/init.zsh"

            export LOMBOK_JAR_PATH=${pkgs.lombok}/share/java/lombok.jar

            POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
            if [[ "$TERM_PROGRAM" == "vscode" || -n $CURSOR_TRACE_ID || ! -t 1 ]]; then
              ZSH_THEME=""
            else
              ZSH_THEME="powerlevel10k/powerlevel10k"
            fi

            if [[ "$TERM_PROGRAM" == "vscode" || -n $CURSOR_TRACE_ID || ! -t 1 ]]; then
              PROMPT='%n@%m:%~%# '
              RPROMPT=""
            else
              source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
              [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
            fi
          ''
        ];
      };
    };
}
