# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.polkit.enable = true;

  sound = {
    enable = true;
  };
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  users.users.suzumiyaaoba = {
    isNormalUser = true;
    description = "SuzumiyaAoba";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];

    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    usbutils
    wl-clipboard
    clipman
    mako
    unzip
  ];

  environment.pathsToLink = [ "/libexec" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # services.keyd = {
  #   enable = true;

  #   keyboards.default = {
  #     ids = [ "*" ];
  #     settings = {
  #       main = {
  #         capslock = "overload(control, esc)";
  #         ";" = ":";
  #       };
  #       shift = {
  #         ";" = ";";
  #       };
  #     };
  #   };
  # };

  services.xremap = {
    enable = true;
    withWlroots = true;
    userName = "suzumiyaaoba";
    serviceMode = "user";

    config = {
      modmap = [
        {
          remap = {
            CapsLock = "Control_L";
          };
        }
      ];

      keymap = [
        {
          name = "Default";
          remap = {
            Semicolon = "Shift-Semicolon";
            Shift-Semicolon = "Semicolon";
          };
        }
        {
          name = "Emacs";
          application = {
            not = [
              "emacs"
              "foot"
              "org.wezfurlong.wezterm"
            ];
          };
          remap = {
            C-b = { with_mark = "left"; };
            C-f = { with_mark = "right"; };
            C-p = { with_mark = "up"; };
            C-n = { with_mark = "down"; };

            C-a = { with_mark = "home"; };
            C-e = { with_mark = "end"; };

            M-v = { with_mark = "pageup"; };
            C-v = { with_mark = "pagedown"; };

            C-w = [ "C-x" { set_mark = false; } ];
            C-d = [ "delete" { set_mark = false; } ];
            C-k = [ "Shift-end" "C-x" { set_mark = false; } ];
            C-space = { set_mark = true; };

            C-g = [ "esc" { set_mark = false; } ];
          };
        }
      ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    zsh = {
      enable = true;
    };
  };

  programs.nix-ld.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];

    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Color Emoji" ];
	      sansSerif = [ "Noto Sans CJK JP" "Noto Color Emoji" ];
	      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
	      emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
