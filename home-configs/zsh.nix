{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/configs/nixos-config/";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "tmux"
        "sudo"
        "docker"

      ];
    };
    profileExtra = ''
      ZSH_TMUX_AUTOSTART=true
      # Set yazi default editor to nvim
      export EDITOR=="nvim"
      export PATH="$HOME/.cargo/bin:$PATH"
      if [ "$(tty)" = "/dev/tty1" ]; then
          exec hyprland
      fi
    '';
  };
}
