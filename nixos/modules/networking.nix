{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking = {
    hostName = "jupiter";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };
}
