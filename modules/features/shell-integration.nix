{ delib, ... }:
delib.module {
  name = "features.shell-integration";
  options = delib.singleEnableOption false;

  # Cursor's terminal uses this even when iTerm2 is disabled.
  home.ifEnabled.home.file.".iterm2_shell_integration.zsh".source =
    ../../home/.iterm2_shell_integration.zsh;
}
