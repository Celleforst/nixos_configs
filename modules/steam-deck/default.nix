{ config, pkgs, lib, ... }:
let

  # Fetch the "development" branch of the Jovian-NixOS repository
  jovian-nixos = builtins.fetchGit {
    url = "https://github.com/Jovian-Experiments/Jovian-NixOS";
    ref = "development";
  };

in {
  # Import jovian modules
  imports = [ 
      (jovian-nixos + "/modules")
	];

services.xserver.desktopManager.gnome.enable = true;
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
