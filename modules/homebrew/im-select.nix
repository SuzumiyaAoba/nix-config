{ delib, ... }:
delib.module {
  name = "homebrew.im-select";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.brews = [
      "im-select"
    ];
  };
}
