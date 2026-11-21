{
  description = "A very 'basic' flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    preservation.url = "github:nix-community/preservation";
  };

  outputs = inputs: {
    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      fw13 = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.disko.nixosModules.disko
          inputs.preservation.nixosModules.default
          ./hosts/fw13
        ];
      };
    };
  };
}
