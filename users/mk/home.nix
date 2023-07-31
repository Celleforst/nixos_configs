{ config, pkgs, home-manager, ... }:

{
  home.stateVersion = "23.05";

  home.username = "mk";
  home.homeDirectory = "/home/mk";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;


  programs.home-manager.enable = true;


}
