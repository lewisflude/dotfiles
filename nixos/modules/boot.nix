{...}: {
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/EFI";
  };

  boot.supportedFilesystems = ["zfs"];
}
