{ config, pkgs, lib, ... }:

{
  boot = {
    kernelParams = [ "quiet" "splash" ];
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader.grub = {
      enable = true;
      device = lib.mkDefault "nodev";
      efiSupport = lib.mkDefault true;
      useOSProber = lib.mkDefault true;
    };
    loader.efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
