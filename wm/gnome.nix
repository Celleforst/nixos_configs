{ config, pkgs, lib, ... }:

{
  services.xserver = {
  # Enable the X11 windowing system.
    enable = true;


  # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome = {
      enable = true;
    };

    excludePackages = [ pkgs.xterm ];
  };

  # Enable NetworkManager
  networking.networkmanager.enable = true;
  
  # Disable wait-online service for Network Manager
  systemd.services.NetworkManager-wait-online.enable = false;

  # Seahorse (Gnome Keyring)
  programs.seahorse.enable = true;

  # Enable Extensions
  #home = {
   # packages = with pkgs; [
    #  gnome.gnome-tweaks
#
 #     gnomeExtensions.appindicator
  #    gnomeExtensions.extensions-sync
   #   gnomeExtensions.vitals
    #  gnomeExtensions.swap-finger-gestures-3-to-4
     # gnomeExtensions.impatience
#gnomeExtensions.gsconnect
#      gnomeExtensions.burn-my-windows
  #    gnomeExtensions.blur-my-shell
 #     gnomeExtensions.nasa-apod

 #   ];

  #};

  services = {
    gnome = {
      gnome-browser-connector.enable = true;
      gnome-settings-daemon.enable = true;
      core-utilities.enable = false;
    };
  };

  # Remove unwanted Packages
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];
  
}
