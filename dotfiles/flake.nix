{
  description = "My Flake File";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    illogical-impulse.url = "github:sitolam/end-4-dots";
    illogical-impulse.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      settings = import (./. + "/settings.nix") {inherit pkgs;};
    in
  {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ 
    ./configuration.nix
    home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];
  specialArgs = { inherit inputs; };
      };

    };
  };
}
