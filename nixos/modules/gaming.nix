{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    gamescope
    steamtinkerlaunch
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
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
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
  };
}
