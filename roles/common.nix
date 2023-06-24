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
    gitAndTools.gitFull
    wget
    curl
    whois
    xz
    zip
    unzip
    tcpdump
    neovim
  ];
  
  programs.bash.enableCompletion = true;
}
