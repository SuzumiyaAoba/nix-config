{ delib, ... }:
delib.module {
  name = "homebrew.brave-browser";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "brave-browser"
    ];
  };
}
