{ delib, pkgs, ... }:
delib.module {
  name = "programs.kustomize";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      kustomize
    ];
  };
}
