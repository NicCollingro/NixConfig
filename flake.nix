{
  description = "Ni(x)cOS dotfiles";

  outputs = { self, nixpkgs, ...}: {
    nixosConfigurations.Kopernikus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/configuration.nix
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
}
