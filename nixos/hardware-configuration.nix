{ lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  powerManagement.cpuFreqGovernor = "performance";
  fileSystems = {
    "/" = {
      device = "npool/root";
      fsType = "zfs";
    };
    "/home" = {
      device = "npool/home";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/65835c4c-3b5f-4ced-bf61-c73a6e76e562";
    }
  ];

  networking.useDHCP = lib.mkDefault true;
  networking.hostId = "259378f7";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
