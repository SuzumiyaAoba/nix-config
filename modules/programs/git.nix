{ delib, ... }:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption true;

  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = myconfig.constants.username;
      userEmail = myconfig.constants.useremail;

      ignores = [
        "*~"
        "*.swp"
        ".DS_Store"
        ".dir-locals.el"
        "mise.local.toml"
        ".claude/settings.local.json"
        ".mise.local.toml"
      ];

      extraConfig = {
        merge = {
          conflictStyle = "diff3";
        };
        alias = {
          delete-merged-branch = "!f () { git checkout $1; git branch --merged|egrep -v '\\*|develop|main'|xargs git branch -d; git fetch --prune; };f";
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
