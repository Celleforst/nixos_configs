{
  description = "Marcello nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fetch the "development" branch of the Jovian-NixOS repository (Steam Deck)
    jovian-nixos = {
      url = "git+https://github.com/Jovian-Experiments/Jovian-NixOS?ref=development";
      flake = false;
    };

    nur.url = "github:nix-community/NUR";

    #lanzaboote = { 
    #   url = "github:nix-community/lanzaboote"; 
    #   inputs.nixpkgs.follows = "nixpkgs"; 
    #   inputs.flake-compat.follows = "flake-compat"; 
    #   inputs.flake-utils.follows = "flake-utils"; 
    #   inputs.pre-commit-hooks-nix.follows = "pre-commit-hooks"; 
    #};

    nix-on-droid = { 
       url = "github:t184256/nix-on-droid"; 
       inputs.home-manager.follows = "home-manager"; 
       inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, jovian-nixos, nur, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

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
    packages.darwinConfigurations = {
      macbook-pro = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs = inputs;
        modules = [ ./darwin/hosts/macbook-pro.nix ];
      };
    };

    # nixos targets
    packages.nixosConfigurations = {
      nixos-steam-deck = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ ./nixos/hosts/steam-deck/configuration.nix ];
      };

      nixos-vm = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ ./nixos/hosts/vm/configuration.nix ];
      };

      nixos-surface-pro = lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = inputs;
	modules = [ ./nixos/hosts/surface-pro/configuration.nix ];
      };
      
      nixos-macbook-pro = lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = inputs;
	modules = [ ./nixos/hosts/macbook-pro/configuration.nix ];
      };
    };

  });
}
