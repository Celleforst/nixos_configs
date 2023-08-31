{ config, lib, pkgs, inputs, user, hostname, secrets, dotfiles, stateVersion, ... }:

{ 
  imports = [
    # ../modules/services/email
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  programs = {

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraLuaConfig = lib.fileContents "${dotfiles}/private_dot_config/nvim/init.lua";
    };

    git = {
      enable = true;
      userName = "Marcello Krahforst";
      userEmail = "marcello.2001@hotmail.com";
    };

  };

  home.stateVersion = stateVersion;
}


