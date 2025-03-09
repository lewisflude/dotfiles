{ pkgs, config, ... }: {
  home = {
    packages = with pkgs; [
      magnetic-catppuccin-gtk
      nwg-look
      iosevka
      nerd-fonts.iosevka
      gtk4
    ];
    pointerCursor = {
      name = "catppuccin-mocha-mauve-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 32;
      gtk = {
        enable = true;
      };
      hyprcursor = {
        enable = true;
        size = 32;
      };
      x11 = {
        enable = true;
        defaultCursor = "left_ptr";
      };
    };
    sessionVariables = {
      WALLPAPER_DIR = "${config.home.homeDirectory}/wallpapers";
    };
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
    cursorTheme = {
      name = "catppuccin-mocha-mauve-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 32;
    };
  };
  fonts.fontconfig.enable = true;
}
