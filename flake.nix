{
  description = "Ni(x)cOS dotfiles";

  outputs = { self, nixpkgs, ...}: {
    nixosConfigurations.Kopernikus = {
      system = "x86_64-linux";
      modules = [
        ./modules/configuration.nix
        ./modules/hardware-configuration.nix
        ./modules/networkmanager.nix
        ./modules/users.nix
        ./modules/programs.nix
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
}
