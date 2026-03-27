{ delib, emacs-flake, ... }:
delib.module {
  name = "programs.emacs";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    environment.systemPackages = [
      emacs-flake.packages.aarch64-darwin.default
    ];
  };
}
