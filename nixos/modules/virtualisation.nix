{ ... }: {
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
    };

    virtualbox = {
      host.enable = true;
      host.enableExtensionPack = true;
      guest.enable = true;
      guest.dragAndDrop = true;
    };
  };

  users.extraGroups.vboxusers.members = [ "lewis" ];
}
