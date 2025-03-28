{
  programs.hyprpanel = {
    enable = true;
    hyprland.enable = false;
    systemd.enable = true;
    overwrite.enable = true;
    theme = "catppuccin_mocha";
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [ "dashboard" "workspaces" "windowtitle" ];
          middle = [ "media" ];
          right = [ "volume" "network" "bluetooth" "systray" "clock" "notifications" ];
        };
      };
    };

    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };
      menus.dashboard = {
        directories.enabled = false;
        stats.enable_gpu = true;
        shortcuts.left.shortcut1 = {
          command = "firefox";
          icon = "󰈹";
          tooltip = "Firefox";
        };
      };
      theme = {
        bar.transparent = true;
        font.name = "Iosevka";
        font.size = "12pt";
      };
    };
  };
}
