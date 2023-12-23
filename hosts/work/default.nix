{ pkgs, USERNAME, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.${username} = {
    home = "/Users/${username}";
  };
}
