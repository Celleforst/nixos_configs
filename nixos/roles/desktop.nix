{ config, pkgs, lib, ... }:

{
  imports = [
     ./../wm/gnome.nix
     ./core.nix
  ];

  boot = {
    kernelParams = [ "quiet" "splash" ];
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    loader.efi.canTouchEfiVariables = true;
  };

  # Enable sandbox
  #nix.settings.sandbox = true;
  # Automatically optimize store for better storage
  nix.settings.auto-optimise-store = true;

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

# Enable Tailscale
  #services.tailscale.enable = true;

# Configure keymap in X11
  services.xserver = {
	  layout = "de";
	  xkbVariant = "";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  #console = {
#	  keymap = "de";
 # };

# Enable CUPS to print documents.
  services.printing.enable = true;

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

  ## Experimental flag allows battery reporting for bluetooth devices
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --experimental"
  ];

  # Android debugging
  #programs.adb.enable = true;

  services = {
    logind = {
      extraConfig = "RuntimeDirectorySize=10G";
    };
    unclutter = {
      enable = true;
      timeout = 5;
    };
    syncthing = {
      enable = true;
      user = "mk";
      dataDir = "/home/mk";
      configDir = "/home/mk/.config";
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


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Allow x86 packages to be installed on aarch64
  nixpkgs.config.allowUnsupportedSystem = true;

  #networking.firewall = {
  #  enable = true;
  #  checkReversePath = "loose";
  #  interfaces.tailscale0.allowedTCPPortRanges = [ { from = 1714; to = 1764; } { from = 3131; to = 3131;} ];
  #  interfaces.tailscale0.allowedUDPPortRanges = [  { from = 1714; to = 1764; } ];
  #};

  fonts.fonts = with pkgs; [
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

  # Bluetooth settings
  hardware.bluetooth.settings = {
    # Necessary for Airpods
    General = { ControllerMode = "dual"; } ;
  };


  # Home-manager configs
  #home-manager.users.mk = import ../roles/home-manager/linux.nix { inherit config; inherit pkgs; inherit home-manager; inherit lib; };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    firefox
    bitwarden
    alacritty
    #thunar
    usbutils
    gparted
  ];

  # Home-Manger configs
  #home-manager.users.mk = import ../../roles/home-manager/base.nix { inherit config; inherit pkgs; inherit home-manager; inherit lib; };
}
