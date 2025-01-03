{ pkgs, ... }:

{
  homebrew.brews = [
    "qmk/qmk/qmk"
  ];

  homebrew.casks = [
    "qmk-toolbox"
  ];
}
