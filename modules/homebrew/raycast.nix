{ delib, ... }:
delib.module {
  name = "homebrew.raycast";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "raycast"
    ];
  };
}
