{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
