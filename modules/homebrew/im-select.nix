{ delib, ... }:
delib.module {
  name = "homebrew.im-select";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.brews = [
      "im-select"
    ];
  };
}
