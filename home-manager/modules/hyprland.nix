{ pkgs, inputs, ... }: {

  home.packages = with pkgs; [
    hyprpolkitagent
    hyprshot
    hyprpicker
    nwg-dock-hyprland
    wayland-utils
    wl-clipboard
    brightnessctl
    dconf
  ];

   imports = [
    ./hyprland/default.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd = {
      enable = false;
      variables = [ "--all" ];
    };
    plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    ];
    settings = {
      monitor = ",preferred,auto,auto";
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "fuzzel --launch-prefix='uwsm app -- '";
    };     
  };
}

