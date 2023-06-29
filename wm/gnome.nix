{ config, pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
  };
  #services.gnome.core-utilities.enable = false;

  # Enable NetworkManager
  networking.networkmanager.enable = true;
  
  # Disable wait-online service for Network Manager
  systemd.services.NetworkManager-wait-online.enable = false;

  # Seahorse (Gnome Keyring)
  programs.seahorse.enable = true;

  services = {
    gnome = {
      gnome-browser-connector.enable = true;
      evolution-data-server.enable = true;
    };
  };

}
