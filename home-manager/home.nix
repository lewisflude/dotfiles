{ ... }: {
  imports = [
    ./modules/sh.nix
    ./modules/browser.nix
    ./modules/desktop-environment.nix
    ./modules/editor.nix
    ./modules/password-management.nix
    ./modules/terminal.nix
    ./modules/theme.nix
    ./modules/window-manager.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "lewis";
    homeDirectory = "/home/lewis";
  };
  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
