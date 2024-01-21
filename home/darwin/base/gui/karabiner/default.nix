{ pkgs, ... }:

{
  home.packages = with pkgs; [
    karabiner-elements
  ];

  home.file = {
    ".config/karabiner/assets".source = ./assets;
    ".config/karabiner/karabiner.json".source = ./karabiner.json;
  };
}
