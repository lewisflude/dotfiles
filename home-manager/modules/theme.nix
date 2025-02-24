{ pkgs, config, inputs, ... }: {
  home.packages = with pkgs; [
    inputs.catppuccin.packages.${system}.default
    magnetic-catppuccin-gtk
    nwg-look
  ];


  home.sessionVariables = {
    WALLPAPER_DIR = "${config.home.homeDirectory}/wallpapers";
    HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    XCURSOR_SIZE = 16;
    GTK_THEME = "Catppuccin-GTK-Dark";

  };

  catppuccin = {
    flavor = "mocha";
    enable = true;
    cursors.enable = true;
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
