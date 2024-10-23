{ ... }:

let
  baseDir = ../../..;
in
{  
  imports = builtins.map (f: baseDir + "/${f}") [
    "modules/darwin/homebrew.nix"

    "modules/darwin/base/ime.nix"
    "modules/darwin/base/commands/sdkman.nix"
    "home/darwin/base/gui/1password.nix"
  ];
}
