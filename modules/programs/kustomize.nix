{ delib, pkgs, ... }:
delib.module {
  name = "programs.kustomize";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      kustomize
    ];
  };
}
