{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (callPackage ../../../pkgs/tools/misc/keg {})
  ];
}
