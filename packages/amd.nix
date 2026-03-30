{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu.opencl.enable = true;
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  hardware.amdgpu.overdrive.enable = true;

  services.lact.enable = true;
}
