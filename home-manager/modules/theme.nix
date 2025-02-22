{pkgs, config, ...}: {
  home.packages = with pkgs; [
    inputs.catppuccin.packages.${pkgs.system}.default
  ];

  home.sessionVariables = {
    WALLPAPER_DIR = "${config.home.homeDirectory}/wallpapers";
  };

  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-GTK-Dark";
      package = pkgs.magnetic-catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
