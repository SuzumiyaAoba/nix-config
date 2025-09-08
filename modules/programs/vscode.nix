{ delib, ... }:
delib.module {
  name = "programs.vscode";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.vscode = {
      enable = true;
    };
  };
}
