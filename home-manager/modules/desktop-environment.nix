{ config
, inputs
, pkgs
, ...
}: {

  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    inputs.ags.packages.${system}.io
    inputs.astal.packages.${system}.astal3
    fuzzel
    mako
  ];

  programs.hyprlock = {
    enable = true;
    settings = { };
    extraConfig = "source=${
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/hyprlock/refs/heads/main/hyprlock.conf";
          sha256 = "1w02cnmi2ikrsnhq7raf0cvnsg0rv9nvaym19xhgbca4j03g0rbx";
        }
      }";
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=12";
        terminal = "kitty";
        layer = "overlay";
        width = 30;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 5;
        lines = 15;
        line-height = 20;
        letter-spacing = 0;
        image-size-ratio = 0.5;
        prompt = "> ";
        indicator-radius = 0;
        tabs = 4;
        icons-enabled = true;
        fuzzy = true;
        drun-launch = true;
      };

      border = {
        width = 2;
        radius = 10;
      };
      dmenu = {
        exit-immediately-if-empty = true;
      };
      key-bindings = {
        cancel = "Escape Control+g";
        execute = "Return KP_Enter Control+y";
        execute-or-next = "Tab";
        cursor-left = "Left Control+b";
        cursor-right = "Right Control+f";
        cursor-home = "Home Control+a";
        cursor-end = "End Control+e";
        delete-prev = "BackSpace";
        delete-next = "Delete";
        delete-line = "Control+k";
        prev = "Up Control+p";
        next = "Down Control+n";
        first = "Home";
        last = "End";
        page-prev = "Page_Up";
        page-next = "Page_Down";
      };
    };
  };
  programs.ags = {
    enable = true;

    configDir = ./lib/ags;
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.tray

      fzf
    ];
  };

  services.mako.enable = true;

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      preload = [ "${config.home.sessionVariables.WALLPAPER_DIR}/lighthouse.png" ];
      wallpaper = ",${config.home.sessionVariables.WALLPAPER_DIR}/lighthouse.png";
      "wallpaper DP-1,fit" = "${config.home.sessionVariables.WALLPAPER_DIR}/lighthouse.png";
    };
  };
}
