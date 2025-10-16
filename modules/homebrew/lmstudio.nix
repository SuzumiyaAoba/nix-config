{ delib, ... }:
delib.module {
  name = "homebrew.lmstudio";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "lm-studio"
    ];
  };
}
