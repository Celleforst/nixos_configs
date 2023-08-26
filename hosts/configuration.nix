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
  ];
  
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    git = {
      enable = true;
      #userName = "Marcello Krahforst";
      #userEmail = "marcello.2001@hotmail.com";
    };
  };

  services.xserver = {
    layout = lib.mkDefault "de";
    xkbOptions = "caps:escape";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Zurich";

  nixpkgs.config.allowUnfree = lib.mkDefault true;
  nixpkgs.config.allowUnsupportedSystem = lib.mkDefault true;

  documentation.nixos.enable = false;
  programs.bash.enableCompletion = true;

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
