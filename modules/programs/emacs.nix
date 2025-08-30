{ delib, emacs-flake, ...}:
delib.module {
  name = "programs.emacs";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    environment.systemPackages = [
      emacs-flake.packages.aarch64-darwin.default
      emacs-flake.packages.aarch64-darwin.emacsclient
      emacs-flake.packages.aarch64-darwin.emacseditor
    ];
  };
}
