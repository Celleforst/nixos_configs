{ config, pkgs, lib, ...  }:
{ 
  imports = [ ../../modules/desktop/gnome ];
  services.xserver.enable = true;

}

