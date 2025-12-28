{
  description = "My Flake File";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    illogical-impulse.url = "github:sitolam/end-4-dots";
    illogical-impulse.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, winapps, ... } @inputs:
    let
      mkHost =
        { hostname
        , system
        , profileDir
        }:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          baseSettings = import ./settings.nix { inherit pkgs; };
          monitors = import ./profiles/${profileDir}/monitors.nix;

          # Host-specific overrides, plus always attach system/hostname
          settings =
            baseSettings
            // {
              inherit hostname system monitors;
              profile = profileDir;
            };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./profiles/${profileDir}/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit inputs settings winapps;
            unstable = nixpkgs-unstable.legacyPackages.${system};
          };
        };
    in
    {
      nixosConfigurations = {
        laptop = mkHost {
          hostname = "laptop";
          system = "x86_64-linux";
          profileDir = "laptop";
        };

        desktop = mkHost {
          hostname = "desktop";
          system = "x86_64-linux";
          profileDir = "desktop";
        };
      };
    };
}
