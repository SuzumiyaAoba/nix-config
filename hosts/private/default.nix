{ pkgs, config, username, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.${username} = {
    home = "/Users/${username}";
  };
}
