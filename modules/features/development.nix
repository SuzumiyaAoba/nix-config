{ delib, lib, ... }:
delib.module {
  name = "features.development";
  options = delib.singleEnableOption false;

  # Hosts can override individual tools with an ordinary enable assignment.
  myconfig.ifEnabled = {
    programs.ast-grep.enable = lib.mkDefault true;
    programs.cargo-make.enable = lib.mkDefault true;
    programs.clive.enable = lib.mkDefault true;
    programs.cmake.enable = lib.mkDefault true;
    programs.cmigemo.enable = lib.mkDefault true;
    programs.ditaa.enable = lib.mkDefault true;
    programs.duckdb.enable = lib.mkDefault true;
    programs.emacs.enable = lib.mkDefault true;
    programs.emacs-lsp-booster.enable = lib.mkDefault true;
    programs.gcc.enable = lib.mkDefault true;
    programs.gh.enable = lib.mkDefault true;
    programs.glab.enable = lib.mkDefault true;
    programs.global.enable = lib.mkDefault true;
    programs.imagemagic.enable = lib.mkDefault true;
    programs.java.enable = lib.mkDefault true;
    programs.jd-diff-patch.enable = lib.mkDefault true;
    programs.kustomize.enable = lib.mkDefault true;
    programs.lua.enable = lib.mkDefault true;
    programs.mkcert.enable = lib.mkDefault true;
    programs.mysql.enable = lib.mkDefault true;
    programs.neovim.enable = lib.mkDefault true;
    programs.oracle.enable = lib.mkDefault true;
    programs.pandoc.enable = lib.mkDefault true;
    programs.rust.enable = lib.mkDefault true;
    programs.tbls.enable = lib.mkDefault true;
    programs.tokei.enable = lib.mkDefault true;
    programs.uv.enable = lib.mkDefault true;
    programs.vhs.enable = lib.mkDefault true;
    homebrew.intellij-idea.enable = lib.mkDefault true;
    homebrew.rancher.enable = lib.mkDefault true;
    homebrew.rtk.enable = lib.mkDefault true;
    homebrew.tgrep.enable = lib.mkDefault true;
    homebrew.vscode.enable = lib.mkDefault true;
  };
}
