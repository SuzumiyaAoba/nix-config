{ delib, ... }:
delib.module {
  name = "homebrew.aquaskk";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "aquaskk"
    ];
  };
}
