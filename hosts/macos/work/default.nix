{ pkgs, username, ... }:

{
  users.users.${username} = {
    home = "/Users/${username}";
  };

  imports = [
    ../../../modules/darwin
  ];
}
