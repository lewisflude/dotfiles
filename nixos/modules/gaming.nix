{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
    protonup-qt
    mangohud
    gamescope
  ];

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
