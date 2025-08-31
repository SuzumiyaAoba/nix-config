{ username, homebrew-qmk, homebrew-arm, homebrew-avr, ... }:

let
  baseDir = ../../..;
in
{
  nix-homebrew.taps = {
    "qmk/homebrew-qmk" = homebrew-qmk;
    "osx-cross/homebrew-arm" = homebrew-arm;
    "osx-cross/homebrew-avr" = homebrew-avr;
  };

  imports = builtins.map (f: baseDir + "/${f}") [
    "modules/darwin/homebrew.nix"

    # IME
    "home/darwin/homebrew/aquaskk.nix"

    # GUI
    "home/darwin/homebrew/google-chrome.nix"
    "home/darwin/homebrew/1password.nix"
    "home/darwin/homebrew/brave-browser.nix"
    "home/darwin/homebrew/shortcat.nix"

    # CLI
    "home/darwin/homebrew/rancher.nix"
    "home/darwin/homebrew/sdkman.nix"

    "home/darwin/homebrew/gcc.nix"
    "home/darwin/homebrew/qmk.nix"
  ];
}
