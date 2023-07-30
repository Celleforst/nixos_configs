{ config, pkgs, lib, ... }:

{
  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce true;
  boot.loader.systemd-boot.enable = true;
}
