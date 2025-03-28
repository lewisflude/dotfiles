{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };
    nvidia-container-toolkit.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      forceFullCompositionPipeline = true;
      nvidiaPersistenced = true;
    };
  };

  environment.sessionVariables = {
    "NIXOS_OZONE_WL" = "1";
    "LIBVA_DRIVER_NAME" = "nvidia";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "NVD_BACKEND" = "nvidia-drm";
    "__GL_GSYNC_ALLOWED" = "1";
    "__GL_VRR_ALLOWED" = "1";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "GDK_SCALE" = "1";
    "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
