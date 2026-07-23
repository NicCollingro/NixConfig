{config, lib, pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    ./networkmanager.nix
    ./users.nix
    ./programs.nix
    ./nix-settings.nix
    ./ly.nix
  ];

  boot.loader = {
  grub = {
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    enable = true;
  };
  efi.canTouchEfiVariables = true;
  };

  networking.hostName="Kopernikus-linux";

  security.polkit.enable = true;

  system.stateVersion = "26.05";
}
