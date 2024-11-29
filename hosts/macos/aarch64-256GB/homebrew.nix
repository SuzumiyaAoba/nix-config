{ ... }:

let
  baseDir = ../../..;
in
{
  imports = builtins.map (f: baseDir + "/${f}") [
    "modules/darwin/homebrew.nix"

    # IME
    "home/darwin/homebrew/aquaskk.nix"

    # GUI
    "home/darwin/homebrew/google-chrome.nix"
    "home/darwin/homebrew/1password.nix"
    "home/darwin/homebrew/brave-browser.nix"

    # CLI
    "home/darwin/homebrew/rancher.nix"
    "home/darwin/homebrew/sdkman.nix"

    "home/darwin/homebrew/gcc.nix"
  ];
}
