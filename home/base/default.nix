{ ... }:

{
  imports = [
    ./shell
    ./terminal
    ./commands
    ./languages
    ./editor
    ./ide
    ./fonts.nix
    ./browser
  ];

  home = {
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "emacs";
    };
  };

  programs.home-manager.enable = true;

  # Workaround for "unable to download 'https://git.sr.ht/~rycee": https://github.com/nix-community/home-manager/issues/4879#issuecomment-1884851745
  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };
}
