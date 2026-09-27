{ delib, pkgs, ... }:
delib.module {
  name = "features.fonts";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      fontconfig
      hackgen-nf-font
      monaspace
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      # iosevka  # 一時的に無効化 - Node.jsビルドエラーのため
      _0xproto
      (callPackage ../../pkgs/fonts/explex.nix { })
      (callPackage ../../pkgs/fonts/cascadia-next.nix { })
      # Includes the JPDOC/35/LG variants, so no separate jpdoc package is needed.
      (callPackage ../../pkgs/fonts/udev-gothic.nix { })

      nerd-fonts.symbols-only
      cascadia-code
    ];
  };
}
