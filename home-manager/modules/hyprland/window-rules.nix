{
  wayland.windowManager.hyprland.settings = {
    monitor = [ "DP-1, 3440x1440@164.90, 0x0, 1, bitdepth, 10, vrr, 1" ];
    windowrule = [
      "float,class:(clipse)"
      "size 622 652,class:(clipse)"
      "float,class:(pavucontrol|nm-connection-editor|1Password)"
      "workspace special:gaming,class:^(steam_app_).*$"
      "workspace special:gaming,title:^(Steam).*$"
      "workspace special:gaming,class:^(gamescope).*$"
      "workspace special:gaming,class:^(lutris)$"
    ];
    workspace = [
      "special:gaming, rounding:false, blur:false, animation:false"
    ];
  };
}
