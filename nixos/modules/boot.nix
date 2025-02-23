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

  boot.zfs.extraPools = [ "mpool" "bpool" ];
  boot.supportedFilesystems = [ "zfs" ];
}

