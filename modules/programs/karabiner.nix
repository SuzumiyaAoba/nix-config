{ delib, ... }:
delib.module {
  name = "programs.karabiner";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "karabiner-elements"
    ];
  };
}
