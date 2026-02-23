{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../home-configs/ghostty.nix
    ../home-configs/yazi.nix
    ../home-configs/zsh.nix
    ../home-configs/git.nix
  ];

  home.username = "josp";
  home.homeDirectory = "/home/josp";
  programs.git.enable = true;
  home.stateVersion = "25.11";

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
    ".config/opencode" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/configs/opencode";
    };
  };

  programs.ssh = {
    enable = true;
    controlMaster = true;
  };
}
