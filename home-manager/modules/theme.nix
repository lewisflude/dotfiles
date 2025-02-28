{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    magnetic-catppuccin-gtk
    nwg-look
    iosevka
    nerd-fonts.iosevka
  ];

  home.pointerCursor = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;
    gtk = {
      enable = true;
    };
    hyprcursor = {
      enable = true;
      size = 24;
    };
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    WALLPAPER_DIR = "${config.home.homeDirectory}/wallpapers";
    # XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    # XCURSOR_SIZE = 12;
    # GTK_THEME = "Catppuccin-GTK-Dark";
  };

  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = "Iosevka";
      package = pkgs.iosevka;
      size = 12;
    };
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
