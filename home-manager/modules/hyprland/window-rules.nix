{ ... }: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float,class:(clipse)"
      "size 622 652,class:(clipse)"
      "float,class:(pavucontrol|nm-connection-editor|1 password-gui)"
      "fullscreen,class:^steam_app\d+$"
      "monitor 1,class:^steam_app_\d+$"
      "workspace 10,class:^steam_app_\d+$"
    ];
    workspace = [
      "10, border:false, rounding:false"
    ];
  };
}
