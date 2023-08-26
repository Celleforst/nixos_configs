{ lib, inputs, nixpkgs, home-manager, nur, user, jovian-nixos, flake-utils, agenix, ... }:

  flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      #specialArgs = {
      #  inherit system inputs user nixpkgs
      #}

      modules = [
        agenix.nixosModules.default {
          environment.systemPackages = [ agenix.packages.${system}.default ];
	  }

	home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.${user} = import ./users/mk/home.nix;
        }
      ];

      lib = nixpkgs.lib;

    in {

    #not working yet
    #homeManagerConfigurations = {
    #  mk = home-manager.lib.homeManagerConfiguration {
#	inherit system pkgs;
#	username = "mk";
#	homeDirectory = "/home/mk";
#	configuration = {
#	  imports = [
 #	    ./users/mk/home.nix
#	  ];
#	};
 #     };	
  #  };

    # macos targets
#    packages.darwinConfigurations = {
#      macbook-pro = darwin.lib.darwinSystem {
#        system = "x86_64-darwin";
#        specialArgs = inputs;
#        modules = [ ./darwin/hosts/macbook-pro.nix ];
#      };
#    };

    # nixos targets
      nixos-steam-deck = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ ./hosts/steam-deck ];
      };

      nixos-vm = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ ./hosts/vm ];
      };

      nixos-surface-pro = lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = inputs;
	modules = [ ./hosts/surface-pro ];
      };
      
      nixos-macbook-pro = lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = inputs;
	modules = [ ./hosts/macbook-pro ];
      };
  })

