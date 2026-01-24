{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    caelestia-shell.packages.${stdenv.hostPlatform.system}.default
    caelestia-cli.packages.${stdenv.hostPlatform.system}.default
  ];

}
