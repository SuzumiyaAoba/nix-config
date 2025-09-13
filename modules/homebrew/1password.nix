{ delib, ... }:
delib.module {
  name = "homebrew.1password";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "1password"
    ];
  };
}
