{ delib, pkgs, ... }:
delib.module {
  name = "programs.java";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      lombok
    ];

    home.sessionVariables.LOMBOK_JAR_PATH = "${pkgs.lombok}/share/java/lombok.jar";
  };
}
