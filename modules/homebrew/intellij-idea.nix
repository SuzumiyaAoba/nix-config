{ delib, ... }:
delib.module {
  name = "homebrew.intellij-idea";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "intellij-idea"
    ];
  };
}
