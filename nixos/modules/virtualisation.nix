{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
      enableNvidia = true;
      daemon = {
        settings.features.cdi = true;
      };
    };
  };
}
