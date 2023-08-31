{ config, pkgs, lib, ... }:

{
  networking.wireless.networks = {
   UPC56366C7 = {
     psk = "b73bPhnfcycN";
   };
   Villa-Altental = {
     psk = "3122825303334032";
   };
  };
}
