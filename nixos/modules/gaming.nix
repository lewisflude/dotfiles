{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
    protonup-qt
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
