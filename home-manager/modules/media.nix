{ pkgs, ... }: {
  home.packages = with pkgs; [
    (ffmpeg-full.override { withUnfree = true; withOpengl = true; })
  ];
}
