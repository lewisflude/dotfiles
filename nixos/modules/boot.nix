{
  boot = {
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      zfsSupport = true;
      mirroredBoots = [
        { devices = [ "nodev" ]; path = "/boot"; }
      ];
    };
    zfs.extraPools = [ "mpool" "bpool" ];
    supportedFilesystems = [ "zfs" ];
    loader.timeout = 0;
    kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" ];
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernel.sysctl = { "fs.file-max" = 524288; };
  };
}

