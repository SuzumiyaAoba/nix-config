{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.carapace";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.carapace = {
      enable = true;

      enableNushellIntegration = true;
      enableZshIntegration = false;
    };

    programs.zsh.initContent = lib.mkOrder 1000 ''
      if [[ -t 1 ]]; then
        source <(${lib.getExe pkgs.carapace} _carapace zsh)
      fi
    '';
  };
}
