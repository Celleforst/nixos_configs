# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./steam-deck.nix
    ];

   boot.loader = {
     efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        useOSProber = true;
        device = "nodev";
        efiSupport = true;
      };
    };

  networking.hostName = "nix-steam-deck"; # Define your hostname.

  services.openssh.enable=true;

  nixpkgs.config.allowUnfree = true; 

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  system.stateVersion = "24.05";

}
