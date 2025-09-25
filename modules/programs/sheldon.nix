{ delib, pkgs, ... }:
delib.module {
  name = "programs.sheldon";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      sheldon
    ];

    programs.zsh = {
      initExtra = ''
        # Initialize sheldon plugin manager
        if command -v sheldon >/dev/null 2>&1; then
          eval "$(sheldon source)"
        fi
      '';
    };
  };
}
