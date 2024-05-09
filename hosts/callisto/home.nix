{ config, lib, pkgs, inputs, user, hostname, secrets, dotfiles, ... }:
{
  imports = [
    ../../modules/programs/alacritty
    ../../modules/programs/firefox
  ];
# programs = {  
#     alacritty = {
#       enable = true;
#       settings = {
# 	window = {
# 	  dimensions = {
# 	    columns = 75; 
# 	    lines = 24;
# 	    };
# 	  opacity = 0.9;
# 	  #decorations = "none";
# 	};
#
#       colors.vi_mode_cursor.text = "#ff00ff";
#
#       cursor.style.shape = "Beam";
#       };
#     };
#   
#
#   firefox.enable = true;
#   };
 #  programs = {
 #    firefox.enable = true;
 #    alacritty = {
 #      enable = true;
 #      settings = {
	#
	# window = {
	#   dimensions = {
	#     columns = 75; 
	#     lines = 24;
	#     };
	#   opacity = 0.9;
	#   #decorations = "none";
	# };
 #      };
 #    };
 #  };
}



