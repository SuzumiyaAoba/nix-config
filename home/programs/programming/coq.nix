{ pkgs, ... }:

{
  home.packages = with pkgs; [
    coq
    coqPackages.mathcomp-ssreflect
  ];
}
