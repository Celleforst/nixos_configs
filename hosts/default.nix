{ lib, inputs, secrets, dotfiles, hosts, hardwares, systems, isNixOS, isIso, isHardware, user, nixpkgs, home-manager, agenix, ... }:
let
  mkHost = { host, hardware, stateVersion, system, timezone, extraOverlays, extraModules, extraHWModules}: isNixOS: isIso: isHardware:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          allowUnsupportedSystem = true;
        };
       # overlays = [
       #   inputs.nur.overlay
       #   (import ../packages)
       #   (import ../overlays)
       # ] ++ extraOverlays;
      };

      extraArgs = { inherit pkgs inputs isIso isHardware user secrets dotfiles timezone hardware system stateVersion; hostname = "nix-" + host; };

      extraSpecialModules = extraModules ++ lib.optional isHardware ../hardware/${hardware} ++ extraHWModules ++ lib.optional isIso "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix";
    in
    if isNixOS
    then
      nixpkgs.lib.nixosSystem
        {
          inherit system;
          specialArgs = extraArgs;
          modules = [
            ./configuration.nix
            ./${host}
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = extraArgs;
              home-manager.users.${user} = {
                imports = [
                  ./home.nix
                  ./${ host }/home.nix
                ];
              };
            }
          ] ++ extraSpecialModules;
        }
    else
      home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          extraSpecialArgs = extraArgs;
          modules = [
            ./home.nix
            ./${ host }/home.nix
            agenix.nixosModules.default
          ];
        };

  hardwarePermutatedHosts = lib.concatMap (hardware: map (host: host // hardware) hosts) hardwares;
  systemsPermutatedHosts = lib.concatMap (system: map (host: host // system) hardwarePermutatedHosts) systems;
  permutatedHosts = systemsPermutatedHosts;
in
  /*
    We have a list of sets.
    Map each element of the list applying the mkHost function to its elements and returning a set in the listToAttrs format
    builtins.listToAttrs on the result
  */
builtins.listToAttrs (map (mInput@{ host, hardware, system, ... }: { name = "nix-" + host; value = mkHost mInput isNixOS isIso isHardware; }) permutatedHosts)
