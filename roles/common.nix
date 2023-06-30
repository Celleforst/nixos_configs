{ config, pkgs, lib, home-manager, ... }:

{
  imports =
    [
      home-manager.nixosModule
    ];

  home-manager.useGlobalPkgs = true;
  
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
  ];
  
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  documentation.nixos.enable = false;
  programs.bash.enableCompletion = true;
}
