{
  description = "My Flake File";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    illogical-impulse.url = "github:sitolam/end-4-dots";
    illogical-impulse.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs:
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
        };
      };

    };
  };
}
