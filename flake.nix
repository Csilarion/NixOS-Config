{

  description = "AJV's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.theKitchen = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./hosts/theKitchen/configuration.nix 

	home-manager.nixosModules.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.ajv = import ./users/ajv/home.nix;
	    backupFileExtension = "backup";
	  };
	}
      ];
    };
  };
}

