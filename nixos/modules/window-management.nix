{ inputs
, pkgs
, ...
}: {

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {
      enableXWayland = true;
      legacyRenderer = false;
      withSystemd = true;
    };
    withUWSM = true;
  };
}
