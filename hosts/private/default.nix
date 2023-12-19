{ pkgs, config, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.private = {
    home = "/Users/${builtins.getEnv "USER"}";
  };
}
