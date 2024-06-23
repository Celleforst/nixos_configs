{ config, pkgs, lib, ... }:

let
  myUsername = "mk";
  myUserdescription = "Marcello Krahforst";

  # Fetch the "development" branch of the Jovian-NixOS repository
  jovian-nixos = builtins.fetchGit {
    url = "https://github.com/Jovian-Experiments/Jovian-NixOS";
    ref = "development";
  };

in {
  # Import jovian modules
  imports = [ "${jovian-nixos}/modules" ]; 

  networking.networkmanager.enable = true;
  # Enable GNOME
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  # Create user
  users.users.${myUsername} = {
    isNormalUser = true;
    description = myUserdescription;
    extraGroups = ["wheel"];
  };

  jovian = {
    steam = {
	enable = true;
	autoStart = true;
	desktopSession = "gnome";
	user = myUsername;
    };
    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
      enableGyroDsuService = true;
    };
    decky-loader = {
      enable = true;
    };
  };

  boot.loader.grub.extraConfig = ''GRUB_CMDLINE_LINUX="video=efifb fbcon=rotate:1"'';

  environment.systemPackages = with pkgs; [
    gnome.gnome-terminal
    firefox
    vim
    git
    curl
  ];
}
