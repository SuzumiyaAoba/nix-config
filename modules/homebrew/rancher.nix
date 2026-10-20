{ delib, lib, ... }:
delib.module {
  name = "homebrew.rancher";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "rancher"
    ];
  };

  home.ifEnabled.programs.zsh.initContent = lib.mkOrder 1060 ''
    export PATH="$HOME/.rd/bin:$PATH"
  '';
}
