{ delib, pkgs, ...}:
delib.module {
  name = "programs.jd-diff-patch";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      jd-diff-patch
    ];
  };
}
