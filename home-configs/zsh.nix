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
      nrs = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
    };
    profileExtra = ''
      # Set yazi default editor to nvim
      export EDITOR=="nvim"
      export PATH="$HOME/.cargo/bin:$PATH"
      if [ "$(tty)" = "/dev/tty1" ]; then
          exec hyprland
      fi
    '';
  };
}
