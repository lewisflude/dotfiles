{ pkgs, ... }: {

  home.packages = with pkgs; [
    clipse
    tmux
    wget
    curl
    comma
    devenv
    direnv
    ghostty
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "Iosevka";
      font-size = 12;
      background-opacity = 0.9;
      background-blur = true;
      shell-integration = "zsh";
      shell-integration-features = true;
      gtk-adwaita = true;
      window-padding-x = 12;
      window-padding-y = 12;
    };
  };
}

