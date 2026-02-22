{ pkgs, inputs, ... }:
{
  environment.systemPackages = [
    inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.vulkan
  ];

}
