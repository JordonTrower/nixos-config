{
  config,
  pkgs,
  caelestia-shell,
  inputs,
  ...
}:

{
  imports = [
    ./home-configs/hyprland.nix
    ./home-configs/kitty.nix
    ./home-configs/ghostty.nix
    ./home-configs/zsh.nix
    ./home-configs/yazi.nix
    ./home-configs/git.nix
  ];

  home.username = "josp";
  home.homeDirectory = "/home/josp";
  programs.git.enable = true;
  home.stateVersion = "25.11";

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/nvim-config";
    };
    ".config/caelestia" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/caelestia";
    };
  };
}
