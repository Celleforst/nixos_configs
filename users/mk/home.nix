{ config, pkgs, home-manager, ... }:

{
  home.username = "mk";
  home.homeDirectory = "/home/mk";

  #home-manager.useGlobalPkgs = true;
  #home-manager.useUserPackages = true;

  programs.git = {
   userName = "Marcello Krahforst";
  };

  programs.home-manager.enable = true;


  home.stateVersion = "23.05";
}
