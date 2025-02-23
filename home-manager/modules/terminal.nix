{ pkgs, ... }: {

  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
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
}
