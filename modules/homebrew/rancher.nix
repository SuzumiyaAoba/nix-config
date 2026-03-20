{ delib, ... }:
delib.module {
  name = "homebrew.rancher";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew.casks = [
      "rancher"
    ];
  };
}
