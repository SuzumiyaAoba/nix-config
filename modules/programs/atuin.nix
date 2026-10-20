{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.atuin";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [ pkgs.atuin ];
    xdg.configFile."atuin/init.zsh".source = ../../home/.config/atuin/init.zsh;

    programs.zsh.initContent = lib.mkOrder 1020 ''
      source "$HOME/.config/atuin/init.zsh"
    '';
  };
}
