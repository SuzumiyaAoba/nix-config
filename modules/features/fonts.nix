{ delib, pkgs, ... }:
delib.module {
  name = "fonts";

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

      nerd-fonts.symbols-only
      cascadia-code
    ];
  };
}
