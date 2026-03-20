{ delib, ... }:
delib.module {
  name = "homebrew.gas-mask";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "gas-mask"
    ];
  };
}
