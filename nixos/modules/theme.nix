{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    magnetic-catppuccin-gtk
    catppuccin-cursors.mochaMauve
    nwg-look
  ];

  environment.sessionVariables = {
    HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    HYPRCURSOR_SIZE = 16;
    XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    XCURSOR_SIZE = 16;
    GTK_THEME = "Catppuccin-GTK-Dark";
  };
}
