{
  config,
  pkgs,
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
    ./home-configs/gtk.nix
  ];

  home.username = "josp";
  home.homeDirectory = "/home/josp";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  services.easyeffects.enable = true;

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.ghostty}/bin/ghostty -e ${pkgs.yazi}/bin/yazi";
      };
    };

  };

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/nvim-config";
    };
    ".qwen" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/qwen";
    };
    ".config/caelestia" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/caelestia";
    };
    ".config/noctalia" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/noctalia";
    };
  };
}
