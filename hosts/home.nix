{ config, lib, pkgs, inputs, user, hostname, secrets, dotfiles, stateVersion, ... }:
{ 
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = stateVersion;

  };
}
