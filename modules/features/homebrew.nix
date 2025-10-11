{
  delib,
  config,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "features.homebrew";

  options = delib.singleEnableOption true;

  darwin.always =
    { myconfig, ... }:
    let
      # homebrewディレクトリ内のすべての.nixファイルを動的に読み込み
      homebrewDir = ../homebrew;

      # ディレクトリ内のファイルを読み込んでモジュールマップを作成
      # この方法はNixの評価時に安全に動作します
      homebrewModules = lib.mapAttrs' (name: type:
        if type == "regular" && lib.hasSuffix ".nix" name
        then lib.nameValuePair (lib.removeSuffix ".nix" name) (homebrewDir + "/${name}")
        else lib.nameValuePair "" null
      ) (builtins.readDir homebrewDir);

      # 有効なモジュールのみをフィルタリング
      validHomebrewModules = lib.filterAttrs (name: path: path != null) homebrewModules;
    in
    {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ] ++ (lib.attrValues validHomebrewModules);

      nix-homebrew = {
        enable = true;
        user = myconfig.constants.username;

        enableRosetta = true;

        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
        };

      };

      homebrew = {
        enable = true;
        onActivation = {
          upgrade = true;
          autoUpdate = true;
          cleanup = "zap";
        };
        taps = builtins.attrNames config.nix-homebrew.taps;

        brews = [
          "grep"
          "findutils"
          "gnu-sed"
          "gettext"
        ];
      };
    };
}