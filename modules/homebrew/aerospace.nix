{ delib, ... }:
delib.module {
  name = "homebrew.aerospace";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "nikitabobko/tap/aerospace"
    ];
  };
}
