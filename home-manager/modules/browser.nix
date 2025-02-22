{ ... }: {
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    firefox
  ];

  programs.firefox.enable = true;
}
