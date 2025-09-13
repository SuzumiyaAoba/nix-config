{ delib, ... }:
delib.module {
  name = "homebrew.rancher";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew.casks = [
      "rancher"
    ];
  };
}
