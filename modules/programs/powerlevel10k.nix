{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.powerlevel10k";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      zsh-powerlevel10k
    ];

    home.file.".p10k.zsh".source = ../../home/.p10k.zsh;

    programs.zsh.initContent = lib.mkOrder 1100 ''
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      if [[ "$TERM_PROGRAM" == "vscode" || -n $CURSOR_TRACE_ID || ! -t 1 ]]; then
        ZSH_THEME=""
        PROMPT='%n@%m:%~%# '
        RPROMPT=""
      else
        ZSH_THEME="powerlevel10k/powerlevel10k"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      fi
    '';
  };
}
