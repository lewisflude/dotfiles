{ lib
, modulesPath
, pkgs
, ...
}: {

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  environment.systemPackages = with pkgs; [
    mergerfs
    xfsprogs
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
    "/mnt/disk1" = {
      device = "/dev/disk/by-id/ata-WDC_WD140EDFZ-11A0VA0_9LGED2YG-part1";
      fsType = "xfs";
      options = [ "defaults" "nofail" "noatime" "logbufs=8" "allocsize=64m" ];
    };

    "/mnt/disk2" = {
      device = "/dev/disk/by-id/ata-WDC_WD140EDFZ-11A0VA0_Y5JTWKLC-part1";
      fsType = "xfs";
      options = [ "defaults" "nofail" "noatime" "logbufs=8" "allocsize=64m" ];
    };
    "/mnt/storage" = {
      device = "/mnt/disk1:/mnt/disk2";
      fsType = "fuse.mergerfs";
      options = [
        "defaults"
        "nonempty"
        "allow_other"
        "use_ino"
        "cache.files=partial"
        "dropcacheonclose=true"
        "category.create=mfs"
        "minfreespace=50G"
      ];
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
