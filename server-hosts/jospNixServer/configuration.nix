{ config, pkgs, ... }:
{
  imports = [ ./nginx-server.nix ];

  # Use the same user configuration as other hosts
  users.users.josp = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "nginx"
    ];
    packages = with pkgs; [ tree ];
  };

  # Basic server configuration
  networking.hostName = "josp-server";
  services.getty.autologinUser = "josp";
  users.users.josp.shell = pkgs.zsh;
  programs.zsh.enable = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Timezone
  time.timeZone = "America/Detroit";

  # System packages
  environment.systemPackages = with pkgs; [
    (import ./server-packages.nix { inherit pkgs; })
    docker
    docker-compose
  ];

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # State version
  system.stateVersion = "25.11";
}
