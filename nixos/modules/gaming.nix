{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
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
