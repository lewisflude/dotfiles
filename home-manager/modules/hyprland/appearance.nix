{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 12;
      gaps_out = 24;
      border_size = 1;
      resize_on_border = false;
      layout = "dwindle";
      snap = {
        enabled = true;
        window_gap = 12;
        monitor_gap = 12;
      };
    };
    xwayland = {
      force_zero_scaling = true;
    };
    decoration = {
      rounding = 4;
      rounding_power = 4;
      active_opacity = 0.90;
      inactive_opacity = 0.70;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
      };

      blur = {
        enabled = true;
        size = 12;
        passes = 3;
      };
    };
    input = {
      accel_profile = "adaptive";
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = true;
    };
    master = {
      new_status = "master";
    };
    misc = {
      force_default_wallpaper = -1;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      vrr = 1;
    };
    render = {
      direct_scanout = "1";
    };
    ecosystem = {
      no_donation_nag = true;
      no_update_news = true;
    };
  };
}
