{ delib, ... }:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.git = { myconfig, ... }: {
      enable = true;
      lfs.enable = true;

      userName = myconfig.constants.username;
      userEmail = myconfig.constatns.useremail;

      ignores = [
        "*~"
        "*.swp"
        ".DS_Store"
        ".dir-locals.el"
        "mise.local.toml"
        ".claude/settings.local.yml"
      ];

      alias = {
        delete-merged-branch = "!f () { git checkout $1; git branch --merged|egrep -v '\\*|develop|main'|xargs git branch -d; git fetch --prune; };f";
      };

      extraConfig = {
        merge = {
          conflictStyle = "diff3";
        };
      };

      diff-so-fancy = {
        enable = false;
      };

      difftastic = {
        enable = true;

        # display = "inline";
        background = "dark";
      };
    };
  };
}
