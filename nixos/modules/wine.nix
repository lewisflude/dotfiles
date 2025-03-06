{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    winetricks
    (wineWowPackages.waylandFull.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    protontricks
  ];
}
