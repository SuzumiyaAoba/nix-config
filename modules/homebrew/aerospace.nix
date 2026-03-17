{ delib, ... }:
delib.module {
  name = "homebrew.aerospace";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "nikitabobko/tap/aerospace"
    ];
  };
}
