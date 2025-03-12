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
    zellij
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    ghostty = {
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
        window-decoration = "server";
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config = {
        italic-text = "always";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
    };
  };
}

