{ delib, ... }:
delib.module {
  name = "homebrew.gas-mask";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "gas-mask"
    ];
  };
}
