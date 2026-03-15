{ delib, ... }:
delib.module {
  name = "homebrew.raycast";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "raycast"
    ];
  };
}
