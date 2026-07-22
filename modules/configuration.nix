{config, lib, pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    ./networkmanager.nix
    ./users.nix
    ./programs.nix
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

  system.stateVersion = "26.05";
}
