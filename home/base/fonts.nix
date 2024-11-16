{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hackgen-nf-font
    monaspace
    iosevka
    _0xproto
    (callPackage ../../pkgs/data/fonts/explex { })

    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
      ];
    })
    cascadia-code
  ];
}
