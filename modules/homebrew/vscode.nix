{ delib, ... }:
delib.module {
  name = "homebrew.vscode";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "visual-studio-code"
    ];
  };
}
