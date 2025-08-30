{ delib, pkgs, ... }:
delib.module {
  name = "fonts";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      hackgen-nf-font
      monaspace
      iosevka
      _0xproto
      (callPackage ../../pkgs/fonts/explex.nix { })
      (callPackage ../../pkgs/fonts/cascadia-next.nix { })

      nerd-fonts.symbols-only
      cascadia-code
    ];
  };
}
