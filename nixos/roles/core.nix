{ config, pkgs, lib, ... }:

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
    git
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
    };
  };

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
