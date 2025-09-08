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

          ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
          [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
          [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
          source "''${ZINIT_HOME}/zinit.zsh"

          if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
          fi

          source "$HOME/.config/zsh/init.zsh"

          export LOMBOK_JAR_PATH=${pkgs.lombok}/share/java/lombok.jar

          # zprof
        '';
      };
    };
}
