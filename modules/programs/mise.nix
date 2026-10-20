{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.mise";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    xdg.configFile."mise".source = ../../home/.config/mise;

    home.packages = with pkgs; [
      mise
    ];

    programs.zsh.initContent = lib.mkOrder 1040 ''
      eval "$(${pkgs.mise}/bin/mise activate zsh)"
    '';
  };
}
