{
  wayland.windowManager.hyprland.settings = {
    exec = [
      "uwsm app -- nwg-dock-hyprland -d"
      "uwsm app -- nwg-drawer -r"
      "uwsm app -- clipse -listen"
    ];
    exec-once = [
      "uwsm app -- hyprpanel"
      "uwsm app -- solaar"
      "systemctl --user enable --now hypridle.service"
      "systemctl --user enable --now hyprpolkitagent.service"
      "pw-link \'Main-Output-Proxy:monitor_FL\' \'alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0:playback_AUX0\'"
      "pw-link \'Main-Output-Proxy:monitor_FR\' \'alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0:playback_AUX1\'"
      "gnome-keyring-daemon --start --components=secrets"
    ];
  };
}
