{ username, ... }:

{
  # Homebrew 自体を Nix でインストール
  # see: https://github.com/zhaofengli/nix-homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    autoMigrate = true;
    user = "${username}";
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
    };

    taps = [
      "homebrew/services"
      "sdkman/tap"
    ];

    caskArgs.language = "ja";
  };
}
