{ config, pkgs, lib, ... }:

{
  imports =
    [
     <home-manager/nixos>
    ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
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
    home-manager
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
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  
}
