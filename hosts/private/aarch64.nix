{ pkgs, config, username, ... }: {
  # imports = [
  #   ../../modules/darwin
  #   ./home/aarch64
  # ];

  users.users.${username} = {
    home = "/Users/${username}";
  };
}
