{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
    protonup-qt
    mangohud
    gamescope
  ];

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };


  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
