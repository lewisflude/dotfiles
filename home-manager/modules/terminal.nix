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
    lsd
    zoxide
    rsync
    trash-cli
    bat
    micro
    ripgrep
    fd
    bottom
    duf
    ncdu
    dust
    glances
    procs
    doas
    gping
    mosh
    aria2
    networkmanager
    tldr
    mcfly
    atool
    pigz
    fzf
    jq
    git-extras
    lazygit
    lazydocker
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "Iosevka";
      font-size = 12;
      background-blur = true;
      shell-integration = "zsh";
      shell-integration-features = "cursor,sudo,title";
      font-feature = "+calt,+liga,+dlig";
      gtk-titlebar = true;
      gtk-tabs-location = "top";
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
    };
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.ripgrep = {
    enable = true;
  };
}

