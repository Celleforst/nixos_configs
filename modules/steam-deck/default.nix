{ config, pkgs, lib, ... }:

{
  # Import jovian modules
  imports = [ 
      (jovian-nixos + "/modules")
	];

services.xserver.displayManager.gnome.enable = true;
jovian = {
    steam = {
	enable = true;
	autoStart = true;
	desktopSession = "gnome";
	user = "mk";
    };
    devices.steamdeck = {
      enable = true;
    };
  };
}
