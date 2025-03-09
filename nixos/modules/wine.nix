{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    winetricks
    (wineWowPackages.staging.override
      { waylandSupport = true; }
    )
    protontricks
  ];
}
