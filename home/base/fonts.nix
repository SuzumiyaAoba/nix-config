{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hackgen-nf-font
    monaspace
    iosevka
    _0xproto
    (callPackage ../../pkgs/data/fonts/explex { })
    (callPackage ../../pkgs/data/fonts/cascadia-next { })

    nerd-fonts.symbols-only
    cascadia-code
  ];
}
