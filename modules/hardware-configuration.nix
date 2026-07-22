{config, lib, pkgs, modulesPath, ...}:
{
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot.initrd.availableKernelModules=["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" ={
      device = "/dev/dis/by-uuid/40c037d3-02ff-461c-a8f7-1cbff6804e8c";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/8951-A6B1";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices=[];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
