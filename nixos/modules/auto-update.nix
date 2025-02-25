{ config, pkgs, ... }: {
  systemd.user.services.nix-update = {
    description = "NixOS system update";
    path = [ pkgs.git pkgs.nix pkgs.home-manager ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "nix-update-script" ''
        #!/bin/sh
        set -e
        ${pkgs.sudo}/bin/sudo -E ${config.home.homeDirectory}/.dotfiles/home-manager/modules/scripts/bin/system-update --inputs
      ''}";
    };
  };

  systemd.user.timers.nix-update = {
    description = "Weekly NixOS system update";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Run weekly on Sunday at 8:00 AM
      OnCalendar = "Sun *-*-* 08:00:00";
      Persistent = true; # Run immediately if system was off at scheduled time
      RandomizedDelaySec = "1h"; # Add random delay up to 1 hour
    };
  };
}
