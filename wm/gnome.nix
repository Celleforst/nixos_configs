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

  # Enable NetworkManager
  networking.networkmanager.enable = true;
  
  # Disable wait-online service for Network Manager
  systemd.services.NetworkManager-wait-online.enable = false;

  # Seahorse (Gnome Keyring)
  programs.seahorse.enable = true;

  # Enable Extensions
  environment.systemPackages.gnomeExtensions = with pkgs; [ 
    appindicator 
    extensions-sync
    vitals
    swap-finger-gestures-3-to-4
    impatience
    gsconnect
    burn-my-windows
    blur-my-shell
    nasa-apod
  ];

  services = {
    gnome = {
      gnome-browser-connector.enable = true;
      gnome-settings-daemon.enable = true;
      core-utilities.enable = false;
    };
  };

}
