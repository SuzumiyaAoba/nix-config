{ delib, ... }:
delib.module {
  name = "homebrew.tgrep";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.brews = [
      "tgrep"
    ];
  };
}
