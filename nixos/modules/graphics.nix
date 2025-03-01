{ config, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  environment.sessionVariables = {
    "NIXOS_OZONE_WL" = 1;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
}
