{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "lewis";
  home.homeDirectory = "/home/lewis";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    alejandra
    nil
    nodePackages.bash-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript-language-server
    marksman
    gopls
    pyright
    rust-analyzer
    black
    fzf
    inputs.ags.packages.${pkgs.system}.io
    inputs.astal.packages.${pkgs.system}.astal3
    zsh-powerlevel10k
    meslo-lgs-nf
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    SUDO_EDITOR = "hx";
    WALLPAPER_DIR = "${config.home.homeDirectory}/wallpapers";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.shell = {
    enableShellIntegration = true;
  };

  xdg.configFile."xdg-desktop-portal-gtk/portals.conf".text = ''
    [preferred]
    default=gtk
  '';

  home.file = {
    ".p10k.zsh" = {
      source = ./p10k.zsh;
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
      };

      history.save = 10000;

      history.size = 10000;
      history.ignoreAllDups = true;
      history.path = "${config.home.homeDirectory}/.zsh_history";
      history.ignorePatterns = ["rm *" "pkill *" "cp *"];
      plugins = [
        {
          # will source zsh-autosuggestions.plugin.zsh
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.1";
            sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
          };
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    home-manager.enable = true;
    kitty = {
      enable = true;
      font = {
        name = "JetBrains Mono";
        size = 12;
      };
      settings = {
        window_padding_width = 4;
        hide_window_decorations = "yes";
        confirm_os_window_close = 0;

        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        active_tab_font_style = "bold";

        enable_audio_bell = "no";
        visual_bell_duration = "0.0";

        scrollback_lines = 10000;
        scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";

        repaint_delay = 10;
        input_delay = 3;
        sync_to_monitor = "yes";

        url_style = "curly";
        open_url_with = "default";

        cursor_shape = "beam";
        cursor_blink_interval = "0.5";

        gpu_rendering_delay = "0.0";
      };

      keybindings = {
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
        "ctrl+shift+t" = "new_tab";
        "ctrl+shift+q" = "close_tab";
        "ctrl+shift+right" = "next_tab";
        "ctrl+shift+left" = "previous_tab";
        "ctrl+shift+equal" = "increase_font_size";
        "ctrl+shift+minus" = "decrease_font_size";
        "ctrl+shift+backspace" = "restore_font_size";
      };

      shellIntegration = {
        enableZshIntegration = true;
      };
    };
    fuzzel = {
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
    ags = {
      enable = true;

      configDir = ./ags;
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
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
      };
      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            injection-regex = "nix";
            file-types = ["nix"];
            shebangs = [];
            comment-token = "#";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "${pkgs.alejandra}/bin/alejandra";
            };
          }
        ];
      };
    };
    firefox = {
      enable = true;
    };
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        kamadorueda.alejandra
        (pkgs.catppuccin-vsc.override {
          accent = "mauve";
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = false;
          workbenchMode = "default";
          bracketMode = "rainbow";
          colorOverrides = {};
          customUIColors = {};
        })
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "catppuccin.accentColor" = "mauve";
        "catppuccin.boldKeywords" = true;
        "catppuccin.italicComments" = true;
        "catppuccin.italicKeywords" = true;
        "catppuccin.workbenchMode" = "default";
        "catppuccin.bracketMode" = "rainbow";
      };
    };
  };

  services = {
    mako.enable = true;
    hyprpaper = {
      enable = true;
      settings = {
        ipc = true;
        preload = ["${config.home.sessionVariables.WALLPAPER_DIR}/lighthouse.png"];
        wallpaper = ",${config.home.sessionVariables.WALLPAPER_DIR}/lighthouse.png";
        "wallpaper DP-1,fit" = "${config.home.sessionVariables.WALLPAPER_DIR}/lighthouse.png";
      };
    };
  };

  fonts = {
    fontconfig.enable = true;
  };

  # Enable Catppuccin theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-GTK-Dark";
      package = pkgs.magnetic-catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = true;
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,auto";

      # Set common variables
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "fuzzel";

      # Autostart programs
      exec-once = [
        "clipse -listen"
        "ags run"
        "systemctl --user enable --now hyprpolkitagent.service"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprctl setcursor catppuccin-mocha-mauve-cursors 16"
        "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-GTK-Dark'"
        "gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'"
        "gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono 11'"
      ];

      windowrulev2 = [
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
        "float,class:(pavucontrol|nm-connection-editor)"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      # General configuration
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          vibrancy = 0.2;
          noise = 0.02;
        };
      };

      # Animation settings
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Layout configurations
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # Input configuration
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # Gesture configuration
      gestures = {
        workspace_swipe = false;
      };

      # Device-specific settings
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Miscellaneous settings
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      # Key bindings - combining your existing binds with example ones
      bind =
        [
          # Your existing binds
          "$mod, Q, exec, kitty"
          "$mod, R, exec, fuzzel"
          "$mod, F, exec, firefox"
          ", Print, exec, grimblast copy area"
          "$mod, V, exec,  kitty --class clipse -e 'clipse'"

          # From example config
          "$mod, C, killactive,"
          "$mod, M, exit,"
          "$mod, E, exec, $fileManager"
          # "$mod, V, togglefloating,"
          "$mod, P, pseudo,"
          "$mod, J, togglesplit," # dwindle

          # Window focus with arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Special workspace handling
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"

          # Workspace switching with mouse
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Multimedia key bindings
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Media player controls
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
