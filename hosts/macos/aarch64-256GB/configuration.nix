{ nixpkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  users.users.${username} = {
    home = "/Users/${username}";
  };

  programs.zsh.enable = true;

  environment.variables = {
    EDITOR = "emacs";
  };

  time.timeZone = "Asia/Tokyo";
}
