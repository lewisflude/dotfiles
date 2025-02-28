{ config
, pkgs
, ...
}: {


  home.packages = with pkgs; [
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
        font = "Iosevka:size=12";
        terminal = "ghostty";
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

  services.mako.enable = true;

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on && hyprctl dispatch uwsm event unlock";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 900;
          on-timeout = " loginctl lock-session";
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
      preload = [ "${config.home.sessionVariables.WALLPAPER_DIR}/nix-black-4k.png" ];
      wallpaper = ",${config.home.sessionVariables.WALLPAPER_DIR}/nix-black-4k.png";
      "wallpaper DP-1,fit" = "${config.home.sessionVariables.WALLPAPER_DIR}/nix-black-4k.png";
    };
  };
}
