{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "steam"
      "steam-unwrapped"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "spotify"
      "vintagestory"
    ];

  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    discord
    lshw
    unzip
    p7zip
    yazi
    bitwarden-desktop
    floorp-bin
    firefox
    lact
    audacity
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    wl-clipboard
    spotify
    pavucontrol
    fuzzel
    #games
    wine
    bolt-launcher
    winetricks
    protontricks
    lutris
    vintagestory
    prismlauncher
    xivlauncher

    kdePackages.kdenlive

    clinfo
    openssl
  ];

}
