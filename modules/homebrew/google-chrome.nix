{ delib, ... }:
delib.module {
  name = "homebrew.google-chrome";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "google-chrome"
    ];
  };
}
