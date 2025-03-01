{ ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = [ "DP-1, 3440x1440@164.90, 0x0, 1, bitdepth 10" ];
    windowrulev2 = [
      "float,class:(clipse)"
      "size 622 652,class:(clipse)"
      "float,class:(pavucontrol|nm-connection-editor|1password)"
      "fullscreen,class:^steam_app\d+$"
      "monitor 1,class:^steam_app_\d+$"
      "immediate,class:^steam_app_\d+$"
      "workspace 10,class:^steam_app_\d+$"
    ];
    workspace = [
      "10, border:false, rounding:false"
    ];
  };
}
