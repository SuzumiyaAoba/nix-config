{ delib, ... }:
delib.module {
  name = "homebrew.codexbar";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "steipete/tap/codexbar"
    ];
  };
}
