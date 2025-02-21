{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    pavucontrol
  ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
