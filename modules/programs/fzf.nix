{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fzf";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = false;
    };

    programs.zsh.initContent = lib.mkOrder 910 ''
      if [[ $options[zle] = on && -t 1 ]]; then
        source <(${lib.getExe pkgs.fzf} --zsh)
      fi
    '';
  };
}
