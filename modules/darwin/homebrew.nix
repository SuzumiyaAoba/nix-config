{ username, homebrew-core, homebrew-cask, homebrew-bundle, sdkman-tap, ... }:

{
  # Homebrew 自体を Nix でインストール
  # see: https://github.com/zhaofengli/nix-homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = "${username}";
    mutableTaps = false;

    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;

      "sdkman/homebrew-tap" = sdkman-tap;
    };
  };

  homebrew = {
    enable = true;

  #   onActivation = {
  #     autoUpdate = true;
  #   };
  };
}
