{ ... }: {
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
    };

    virtualbox = {
      host.enable = true;
      host.enableExtensionPack = true;
    };
  };

  programs.dconf.enable = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  users.extraGroups.vboxusers.members = [ "lewis" ];
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
}
