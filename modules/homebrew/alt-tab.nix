{ delib, ... }:
delib.module {
  name = "homebrew.alt-tab";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "alt-tab"
    ];
  };
}
