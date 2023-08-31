{ config, pkgs, lib, ... }:
{
# Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = lib.mkForce true;
    alsa.enable = lib.mkForce true;
    alsa.support32Bit = lib.mkForce true;
    pulse.enable = lib.mkForce true;
  };
}
