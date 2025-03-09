{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
    protonup-qt
    mangohud
    gamescope
  ];
  programs = {
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
  services = {
    ananicy = {
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
    protontweaks.enable = true;
  };
}
