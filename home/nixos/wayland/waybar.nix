{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      # mainBar = {
      #   modules-left = [ "sway/workspaces" ];
      #   modules-centor = [ "sway/window" ];
      #   modules-right = [];
      # };
    };

    style = ''
      * {
        font-family: HackGen Console NF;
      }
    '';
  };
}
