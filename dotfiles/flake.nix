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

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, winapps, ... } @inputs:
    let
      pkgs = nixpkgs.legacyPackages.${settings.system};
      settings = import (./. + "/settings.nix") {inherit pkgs;};
    in
  {
    nixosConfigurations = {
      ${settings.hostname} = nixpkgs.lib.nixosSystem {
        system = settings.system;
	      modules = [ 
          (./. + "/profiles" + ("/" + settings.profile) + "/configuration.nix")          
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
        ];
        specialArgs = { 
          inherit inputs;
          inherit settings;
          inherit winapps;
          unstable = nixpkgs-unstable.legacyPackages.${settings.system}; 
        };
      };

    };
  };
}
