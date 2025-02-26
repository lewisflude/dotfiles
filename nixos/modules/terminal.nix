{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clipse
    tmux
    wget
    curl
    kitty
    comma
    devenv
    direnv
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    loadInNixShell = true;
  };
}
