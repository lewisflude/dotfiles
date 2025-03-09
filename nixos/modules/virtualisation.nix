{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
      daemon = {
        settings.features.cdi = true;
      };
    };
  };
}
