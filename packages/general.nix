{
  lib,
  pkgs,
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
    #games
    wine
    bolt-launcher
    winetricks
    protontricks
    lutris
  ];

  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
  hardware.amdgpu.overdrive.enable = true;
}
