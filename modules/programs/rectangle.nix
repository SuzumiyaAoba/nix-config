{ delib, pkgs, ... }:
delib.module {
  name = "programs.rectangle";

  options = delib.singleEnableOption pkgs.stdenv.isDarwin;

  home.ifEnabled = {
    home.packages = with pkgs; [
      rectangle
    ];
  };
}
