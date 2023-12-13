{ ... }:

{
  programs.zsh = {
    enable = true;
  };

  home.file.".zshrc".source = ./.zshrc;
  home.file.".config/zsh".source = ./config;
}
