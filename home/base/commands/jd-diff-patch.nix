{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jd-diff-patch
  ];
}
