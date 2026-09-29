# Boilerplate from https://wiki.nixos.org/wiki/Home_Manager

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      # Follow stable nixos-26.05 instead of their default to unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, emacs-overlay, ... } @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { # `nixos` refers to my <HOSTNAME>
      system = builtins.currentSystem;
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ emacs-overlay.overlays.default ]; }
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
  };
}
