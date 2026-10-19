{

  description = "AJV's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs, ... }: {
    nixosConfigurations.theKitchen = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./hosts/theKitchen/configuration.nix 
      ];
    };
  };
}

