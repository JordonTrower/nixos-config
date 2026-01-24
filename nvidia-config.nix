{
  config,
  ...
}:

{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:01:0:0";
      amdgpuBusId = "PCI:06:0:0";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
