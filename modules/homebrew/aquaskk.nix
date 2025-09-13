{ delib, ... }:
delib.module {
  name = "homebrew.aquaskk";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "aquaskk"
    ];
  };
}
