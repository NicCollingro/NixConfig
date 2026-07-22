{config, lib, pkgs, ...}:
{
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

  sytem.stateVersion = "26.05";
}
