{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wofi
    yazi
  ];
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    regreet = {
      enable = true;
      theme = {
        name = "Catppuccin-GTK-Dark";
        package = pkgs.magnetic-catppuccin-gtk;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "catppuccin-mocha-mauve-cursors";
        package = pkgs.catppuccin-cursors.mochaMauve;
      };
      settings = {
        background = {
          path = "/home/lewis/wallpapers/nurburgring.png";
          fit = "Contain";
        };
        commands = {
          reboot = [ "systemctl" "reboot" ];
          poweroff = [ "systemctl" "poweroff" ];
        };
        widget.clock = {
          format = "%a %H:%M";
          resolution = "500ms";
        };
      };
    };
    hyprlock = {
      enable = true;
    };
  };
  services = {
    hypridle.enable = true;
  };
}
