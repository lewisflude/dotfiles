{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
      enableNvidia = true;
      daemon = {
        settings = {
          dns = [ "192.168.1.10" "1.1.1.1" "8.8.8.8" ];
          max-concurrent-downloads = 5;
          max-concurrent-uploads = 5;
          features.cdi = true;
          live-restore = true;
          ipv6 = true;
          ip6tables = true;
          fixed-cidr-v6 = "2001:db8:1::/64";
          experimental = true;
          default-address-pools = [
            { base = "172.18.0.0/16"; size = 24; }
            { base = "2001:db8:2::/64"; size = 80; }
          ];
          log-driver = "json-file";
          log-opts = {
            max-size = "10m";
            max-file = "3";
          };
        };
      };
    };
  };

  users.users.lewis.extraGroups = [ "docker" ];
}
