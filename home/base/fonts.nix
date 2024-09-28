{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hackgen-nf-font
    monaspace
    _0xproto
    (callPackage ../../pkgs/data/fonts/explex { })
  ];
}
