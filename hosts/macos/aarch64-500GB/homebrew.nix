{ ... }:

let
  baseDir = ../../..;
in
{
  imports = builtins.map (f: baseDir + "/${f}") [
    "modules/darwin/base/ime.nix"

    "home/darwin/base/gui/1password.nix"
  ];
}
