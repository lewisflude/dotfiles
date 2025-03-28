{ ... }: {
  services.mpd = {
    enable = true;
    network.listenAddress = "any";
    musicDirectory = "/home/lewis/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

}
