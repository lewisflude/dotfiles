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
        commands = {
          reboot = [ "systemctl" "reboot" ];
          poweroff = [ "systemctl" "poweroff" ];
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
