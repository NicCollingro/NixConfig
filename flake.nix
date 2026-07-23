{
  description = "Ni(x)cOS dotfiles";

  outputs = { self, nixpkgs, home-manager, ...}: {
    nixosConfigurations.Kopernikus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/System/configuration.nix
      ];
    };
    homeConfigurations.niccollingro = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs{system = "x86_64-linux"};
      modules = [
        ./modules/User/niccollingro.nix
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
