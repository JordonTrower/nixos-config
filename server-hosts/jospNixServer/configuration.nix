{ config, pkgs, ... }:
{
  imports = [ ./nginx-server.nix ];

  users.users.josp = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "nginx"
    ];
    packages = with pkgs; [ tree ];
  };

  # Basic server configuration
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
  nix.settings.auto-optimise-store = true;

  # Logging
  services.logrotate.enable = true;
  services.journalctl.enable = true;

  # Fail2ban for SSH protection
  services.fail2ban = {
    enable = true;
    logPath = "/var/log/auth.log";
  };

  # State version
  system.stateVersion = "25.11";
}
