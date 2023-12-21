{ pkgs, config, USERNAME, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.${USERNAME} = {
    home = "/Users/${USERNAME}";
  };
}
