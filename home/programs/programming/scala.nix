{ pkgs, ...}:

{
  home.packages = with pkgs; [
    coursier
    metals
  ];
}
