{
  services.zfs = {
    autoSnapshot = {
      enable = true;
      frequent = 4;
      hourly = 24;
      daily = 7;
    };
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
  };
}
