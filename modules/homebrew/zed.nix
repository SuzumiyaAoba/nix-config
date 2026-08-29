{ delib, ... }:
delib.module {
  name = "homebrew.zed";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "zed"
    ];
  };
}
