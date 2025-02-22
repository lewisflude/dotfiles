{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clipse
    tmux
    wget
    curl
    kitty
  ];
}
