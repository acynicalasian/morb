{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { # `nixos` refers to my <HOSTNAME>
        system = "aarch64-linux"; # hardcode to allow pure eval; also this is for my Orbstack
                                  # NixOS VM
        modules = [
          ./configuration.nix
          home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; } # If you want access to inputs in your home.nix
              users.akim = ./home.nix; # `akim` is my <USERNAME>
            };
          }
        ];
      };
    };
}