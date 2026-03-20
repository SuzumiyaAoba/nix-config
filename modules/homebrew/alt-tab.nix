{ delib, ... }:
delib.module {
  name = "homebrew.alt-tab";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "alt-tab"
    ];
  };
}
