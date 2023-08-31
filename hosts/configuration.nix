{ config, pkgs, lib, inputs, home-manager, ... }:

{
  imports =
    [
    ];

  environment.systemPackages = with pkgs; [
    htop
    #telnet
    iotop
    iftop
    rsync
    wget
    curl
    whois
    xz
    zip
    unzip
    tcpdump
    parted
    neovim
  ];

  services.xserver = {
    layout = lib.mkDefault "de";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Zurich";

  # Actually already configured in flake
  nixpkgs.config.allowUnfree = lib.mkDefault true;
  nixpkgs.config.allowUnsupportedSystem = lib.mkDefault true;

  documentation.nixos.enable = false;
  programs.bash.enableCompletion = true;

  users.users = {
    "root" = {
    };

    "mk" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  
}
