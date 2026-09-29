# Boilerplate from https://wiki.nixos.org/wiki/Home_Manager

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { # `nixos` refers to my <HOSTNAME>
        system = "aarch64-linux"; # hardcode to allow pure eval; also this is for my Orbstack
                                  # NixOS VM

        specialArgs = { inherit inputs; };
        modules = [
          ./compose.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.akim = import ./home.nix;
	    # My config intends to declare _everything_. 
	    home-manager.backupCommand = "rm";
	  }
        ];
      };

      # homeConfigurations."akim@nixos" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.aarch64-linux;
      #   extraSpecialArgs = { inherit inputs; };
      #   modules = [
      #    ./home.nix
      #   ];
      # };
    };
}