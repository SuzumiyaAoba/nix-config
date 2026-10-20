{ delib, lib, ... }:
delib.module {
  name = "features.base";
  options = delib.singleEnableOption false;

  # Hosts can override individual tools with an ordinary enable assignment.
  myconfig.ifEnabled = {
    programs.appcleaner.enable = lib.mkDefault true;
    programs.atuin.enable = lib.mkDefault true;
    programs.bat.enable = lib.mkDefault true;
    programs.bottom.enable = lib.mkDefault true;
    programs.carapace.enable = lib.mkDefault true;
    programs.coreutils.enable = lib.mkDefault true;
    programs.delta.enable = lib.mkDefault true;
    programs.difftastic.enable = lib.mkDefault true;
    programs.eza.enable = lib.mkDefault true;
    programs.fd.enable = lib.mkDefault true;
    programs.fzf.enable = lib.mkDefault true;
    programs.fzy.enable = lib.mkDefault true;
    programs.ghq.enable = lib.mkDefault true;
    programs.git.enable = lib.mkDefault true;
    programs.glow.enable = lib.mkDefault true;
    programs.gnupg.enable = lib.mkDefault true;
    programs.iterm.enable = lib.mkDefault true;
    programs.jq.enable = lib.mkDefault true;
    programs.karabiner.enable = lib.mkDefault true;
    programs.lazygit.enable = lib.mkDefault true;
    programs.mise.enable = lib.mkDefault true;
    programs.powerlevel10k.enable = lib.mkDefault true;
    programs.rectangle.enable = lib.mkDefault true;
    programs.ripgrep.enable = lib.mkDefault true;
    programs.sd.enable = lib.mkDefault true;
    programs.tig.enable = lib.mkDefault true;
    programs.tree.enable = lib.mkDefault true;
    programs.wezterm.enable = lib.mkDefault true;
    programs.zellij.enable = lib.mkDefault true;
    programs.zoxide.enable = lib.mkDefault true;
    programs.zsh.enable = lib.mkDefault true;
    homebrew.aquaskk.enable = lib.mkDefault true;
    homebrew.gas-mask.enable = lib.mkDefault true;
    homebrew.google-chrome.enable = lib.mkDefault true;
    features.claude-code.enable = lib.mkDefault true;
    features.serena.enable = lib.mkDefault true;
    features.shell-integration.enable = lib.mkDefault true;
    features.vimium.enable = lib.mkDefault true;
  };
}
