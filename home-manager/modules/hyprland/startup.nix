{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user enable --now hypridle.service"
      "systemctl --user enable --now hyprpolkitagent.service"
      "uwsm app -- clipse -listen"
      "pw-link \'Main-Output-Proxy:monitor_FL\' \'alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0:playback_AUX0\'"
      "pw-link \'Main-Output-Proxy:monitor_FR\' \'alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0:playback_AUX1\'"
      "uwsm app -- nwg-dock-hyprland -d"
      "uwsm app -- nwg-drawer -r"
    ];
  };
}
