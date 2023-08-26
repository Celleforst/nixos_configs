{ config, pkgs, lib, ... }:

{
  boot = {
    kernelParams = [ "quiet" "splash" ];
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
