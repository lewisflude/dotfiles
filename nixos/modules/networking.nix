{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
  networking = {
    hostName = "jupiter";
    enableIPv6 = true;
    networkmanager.enable = true;
    networkmanager.dns = "dnsmasq";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        21 # FTP
        25 # SMTP
        27015 # Steam
        27036 # Steam
        6600 # MPD
        8123 # Home Assistant
        8095
        80 # HTTP
        443 # HTTPS
        5353 # mDNS
        3456
        5555
        5001
        8096 # Jellyfin/Emby
        1188
        8080
        9090
        2875
        2880
        7000 # AirPlay control
        11434 # Ollama
        7878 # Radarr
        8989 # Sonarr
        5055
        5690
        8191
        9696
        3030
        465 # SMTPS
        587 # Submission
        5000 # AirPlay control channel
        7100 # AirPlay screen mirroring
        8008 # Chromecast
        8009 # Chromecast
        8200
        1900 # UPNP
        2869 # UPNP
        554 # RTSP for AirPlay
        3689 # DAAP (iTunes Music Sharing, AirPlay)
        5228 # Siri
        3283 # Apple Remote Desktop
        5900 # Screen sharing/VNC
      ];
      # UDP ports for AirPlay and other services
      allowedUDPPorts = [
        5353 # mDNS (Bonjour, AirPlay)
        1900 # UPNP/DLNA discovery
        8008 # Chromecast
        8009 # Chromecast
        7000 # AirPlay audio
        7100 # AirPlay screen mirroring
        554 # RTSP for AirPlay
        5000 # AirPlay control channel
        5001 # AirPlay control channel
        123 # NTP
        5900 # Screen sharing
        3283 # Apple Remote/Casting
      ];
      # UDP port ranges for streaming
      allowedUDPPortRanges = [
        {
          from = 6000;
          to = 7000; # AirPlay audio streaming
        }
        {
          from = 16384;
          to = 16403; # RTP/RTCP for AirPlay
        }
        {
          from = 49152;
          to = 65535; # Dynamic sessions for AirPlay
        }
      ];
      # TCP port ranges
      allowedTCPPortRanges = [
        {
          from = 49152;
          to = 65535;
        }
      ];
      # Allow multicast for discovery services
      extraCommands = ''
        iptables -A INPUT -p udp -m udp --dport 5353 -d 224.0.0.251 -j ACCEPT
        ip6tables -A INPUT -p udp -m udp --dport 5353 -d ff02::fb -j ACCEPT
      '';
    };
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
  services.dbus.packages = [ pkgs.avahi ];
}
