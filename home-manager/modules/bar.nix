{ ... }: {
  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
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
      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;
      menus.dashboard.shortcuts.left.shortcut1.command = "firefox";
      menus.dashboard.shortcuts.left.shortcut1.icon = "󰈹";
      menus.dashboard.shortcuts.left.shortcut1.tooltip = "Firefox";
      menus.dashboard.shortcuts.left.shortcut2.command = "cider-2";
      menus.dashboard.shortcuts.left.shortcut2.icon = "󰀵";
      menus.dashboard.shortcuts.left.shortcut2.tooltip = "Cider (Apple Music)";
      menus.dashboard.shortcuts.left.shortcut3.command = "vencord";
      menus.dashboard.shortcuts.left.shortcut3.icon = "";
      menus.dashboard.shortcuts.left.shortcut3.tooltip = "Vencord (Discord)";
      theme.bar.transparent = true;
    };
  };
}
