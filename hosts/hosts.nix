{system, lib, agenix, inputs, self, home-manager, ... }:
{

      nixos-macbook-pro = lib.nixosSystem {
	system = "x86_64-linux";
	specialArgs = inputs;
	modules = [ 
	  ./hosts/macbook-pro/configuration.nix
          agenix.nixosModules.default {
            environment.systemPackages = [ agenix.packages.${system}.default ];
	  }

	  home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.mk = import ./users/mk/home.nix;
          }
	];
      };


}


