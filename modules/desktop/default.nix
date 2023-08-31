{ config, pkgs, lib, ... }:

{
  imports = [
     ./gnome
     ./../bootloader/grub
     ../services/wifi
     ../services/printing
     ../services/pipewire
  ];

  # Enable SSH
  services.openssh.enable = true;

  # Open ports in firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = true;

  # Exclude root from displayManager
  services.xserver.displayManager.hiddenUsers = [
    "root"
  ];


  ## Experimental flag allows battery reporting for bluetooth devices
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --experimental"
  ];

  services = {
    logind = {
      extraConfig = "RuntimeDirectorySize=10G";
    };
  };

  # Virtualization
  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "mk" ];
  users.extraGroups.disk.members = [ "mk" ];


  #networking.firewall = {
  #  enable = true;
  #  checkReversePath = "loose";
  #  interfaces.tailscale0.allowedTCPPortRanges = [ { from = 1714; to = 1764; } { from = 3131; to = 3131;} ];
  #  interfaces.tailscale0.allowedUDPPortRanges = [  { from = 1714; to = 1764; } ];
  #};

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "DroidSansMono" "Iosevka" "JetBrainsMono" ]; })
  ];

  users.users.mk = {
    isNormalUser = true;
    description = "Marcello Krahforst";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.zsh;
  };

  environment.homeBinInPath = true;
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
    "/run/current-system/sw/bin/zsh"
  ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    firefox
    bitwarden
    usbutils
    nemo
    qpdfview
    gparted
  ];

}
