{ ... }: {
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    zfsSupport = true;
    mirroredBoots = [
      { devices = [ "nodev" ]; path = "/boot"; }
    ];
  };

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.enableUnstable = true;
}

