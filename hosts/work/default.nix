{ pkgs, ... }: {
  imports = [
    ../../modules/darwin
  ];

  users.users.work = {
    home = "/Users/${builtins.getEnv "USER"}";
  };
}
