{ config, pkgs, lib, ... }:

{
  # Auto Log-In
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "mk";
}
