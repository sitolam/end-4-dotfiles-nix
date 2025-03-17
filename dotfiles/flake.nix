{
  description = "My Flake File";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    illogical-impulse.url = "github:bigsaltyfishes/end-4-dots";
    illogical-impulse.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
  {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./configuration.nix ];
      };

    };

    homeConfigurations = {
      jawadhc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };

  };
}
