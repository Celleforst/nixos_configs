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
    jovian-nixos.url = "git+https://github.com/Jovian-Experiments/Jovian-NixOS?ref=development";

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

    #sops-nix = {
    #  url = "github:Mic92/sops-nix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    agenix = {
      url = "github:ryantm/agenix";
      inputs.agenix.inputs.nixpkgs.follows = "nixpkgs";
      #optionally choose not to download darwin deps (saves some resources on Linux)
      inputs.agenix.inputs.darwin.follows = "";
    };

    flake-utils.url = "github:numtide/flake-utils";

    templates.url = "github:NixOS/templates";

    dotfiles = {
      url = "github:Celleforst/dotfiles";
      flake = false;
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, dotfiles, nixos-hardware, jovian-nixos, ... }@inputs:
    let
      user = "mk";

      secrets = import ./secrets;

      #dotfiles = ./dotfiles;

      hosts = [
	{ host = "callisto"; extraOverlays = [ ]; extraModules = [ ]; timezone = "Europe/Zurich"; }
	{ host = "saturn"; extraOverlays = [ ]; extraModules = [ ]; timezone = "Europe/Zurich"; }
      ];

      #import ./hosts/hosts.nix

      # commonBuilders = [ "bastli-nixos" ];

      hardwares = [
        { hardware = "macbook-pro"; stateVersion = "23.05"; extraHWModules = [ nixos-hardware.nixosModules.apple-t2 ]; }
        { hardware = "steam-deck"; stateVersion = "23.05"; extraHWModules = [ ]; }
        { hardware = "surface-pro"; stateVersion = "23.05"; extraHWModules = [ nixos-hardware.nixosModules.microsoft-surface-pro-intel ]; }
        { hardware = "server"; stateVersion = "23.05"; extraHWModules = [ ]; }
	];
      
      systems = [
	{system = "x86_64-linux";}
	{system = "x86_64-darwin";}
	{system = "aarch64-linux";}
	{system = "aarch64-darwin";}

      ];

      commonInherits = {
	inherit (nixpkgs) lib;
	inherit inputs nixpkgs home-manager agenix jovian-nixos;
	inherit user secrets hosts dotfiles hardwares systems;
      };
    in 
    {
      # nixos targets
      nixosConfigurations = import ./hosts (
	commonInherits // {
	  isNixOS = true;
	  isIso = false;
	  isHardware = true;
	});

      homeConfigurations = import ./hosts (
        commonInherits // {
          isNixOS = false;
	  isIso = false;
	  isHardware = false;
	});

      isoConfigurations = import ./hosts (
        commonInherits // {
          isNixOS = true;
	  isIso = true;
	  isHardware = false;
	});

      nixosNoHardwareConfigurations = import ./hosts (
        commonInherits // {
          isNixOS = true;
	  isIso = false;
	  isHardware = false;
	});
      #inherit (nixpkgs) lib;
      #inherit inputs nixpkgs home-manager nur user jovian-nixos flake-utils agenix;	
    };
}
