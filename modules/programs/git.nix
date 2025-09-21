{ delib, ... }:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption true;

  home.ifEnabled =
    { myconfig, ... }:
    {
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

            dlog  = "-c diff.external=difft log --ext-diff";
            dl    = "-c diff.external=difft log --ext-diff";
            dshow = "-c diff.external=difft show --ext-diff";
            ds    = "-c diff.external=difft show --ext-diff";
            ddiff = "-c diff.external=difft diff";
            dft   = "-c diff.external=difft diff";
          };
        };

        diff-so-fancy = {
          enable = false;
        };

        difftastic = {
          enable = false;
        };
      };
    };
}
