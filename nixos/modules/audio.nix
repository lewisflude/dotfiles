{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulsemixer
    pamixer
    playerctl
  ];
  musnix.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
    extraConfig.pipewire = {
      "20-playback-split.conf" = {
        "context.modules" = [{
          name = "libpipewire-module-loopback";
          args = {
            "node.description" = "Speakers";
            "capture.props" = {
              "node.name" = "Speakers";
              "media.class" = "Audio/Sink";
              "audio.position" = [ "FL" "FR" ];
            };
            "playback.props" = {
              "node.name" = "playback.Speakers";
              "audio.position" = [ "AUX0" "AUX1" ];
              "target.object" = "alsa_output.usb-Apogee_Electronics_Corp_Symphony_Desktop-00.pro-output-0";
              "stream.dont-remix" = true;
              "node.passive" = true;
            };
          };
        }];
      };
    };
  };
}
