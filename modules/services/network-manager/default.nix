{ config, pkgs, lib, user, secrets, ... }:

{
  networking.networkmanager.enable = true;
  environment.etc."NetworkManager/system-connections/eth.nmconnection" = {
    mode = "0600";
    text = 
    ''
    [connection]
    id=eth
    uuid=b2d14474-4a6c-43a7-b617-4306f6c4019f
    type=wifi
    interface-name=wlp3s0
    
    [wifi]
    mode=infrastructure
    ssid=eth

    [wifi-security]
    auth-alg=open
    key-mgmt=wpa-eap

    [802-1x]
    eap=ttls;
    identity=mkrahforst@student-net.ethz.ch
    password= ${builtins.readFile config.age.secrets.eth-wifi.path}"
    phase2-auth=mschapv2

    [ipv4]
    method=auto

    [ipv6]
    addr-gen-mode=default
    method=auto

    [proxy]
    '';

    destination = "/etc/NetworkManager/system-connections/eth.nmconnection";
  };

  # writeTextFile {
  #   name = "UPC56366C7";
  #   text = ''
  #   [connection]
  #   id=UPC56366C7
  #   uuid=83b610d4-c27d-487e-87c5-87dfadbd3a62
  #   type=wifi
  #   interface-name=wlp3s0
  #   
  #   [wifi]
  #   mode=infrastructure
  #   ssid=UPC56366C7
  #   
  #   [wifi-security]
  #   auth-alg=open
  #   key-mgmt=wpa-psk
  #   psk=secrets...
  #   
  #   [ipv4]
  #   method=auto
  #   
  #   [ipv6]
  #   addr-gen-mode=default
  #   method=auto
  #   
  #   [proxy]
  #   '';
  #
  #   destination = "/etc/NetworkManager/system-connections/UPC56366C7.nmconnection";
  # };
  #     
  # writeTextFile {
  #   name = "Villa-Altental";
  #   text = ''
  #   [connection]
  #   id=Villa-Altental
  #   uuid=83b610d4-c27d-487e-87c5-87dfadbd3a62
  #   type=wifi
  #   interface-name=wlp3s0
  #   
  #   [wifi]
  #   mode=infrastructure
  #   ssid=Villa-Altental
  #   
  #   [wifi-security]
  #   auth-alg=open
  #   key-mgmt=wpa-psk
  #   psk=secrets.Villa-Altental
  #   
  #   [ipv4]
  #   method=auto
  #   
  #   [ipv6]
  #   addr-gen-mode=default
  #   method=auto
  #   
  #   [proxy]
  #   '';
  #
  #   destination = "/etc/NetworkManager/system-connections/Villa-Altental.nmconnection";
  # };
}
