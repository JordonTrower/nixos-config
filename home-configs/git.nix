{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "JordonTrower";
        email = "leopardclone@gmail.com";
      };
    };
  };
}
