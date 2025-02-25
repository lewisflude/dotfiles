{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ slack telegram-desktop vencord ];
}
