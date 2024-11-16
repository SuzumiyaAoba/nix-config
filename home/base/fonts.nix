{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hackgen-nf-font
    monaspace
    iosevka
    _0xproto
    (callPackage ../../pkgs/data/fonts/explex { })
    (callPackage ../../pkgs/data/fonts/cascadia-next { })

    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
      ];
    })
    cascadia-code
  ];
}
