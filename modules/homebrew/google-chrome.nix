{ delib, ... }:
delib.module {
  name = "homebrew.google-chrome";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "google-chrome"
    ];
  };
}
