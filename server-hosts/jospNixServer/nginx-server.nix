# Nginx configuration for local web server
# This will be imported into the NixOS configuration
{ config, pkgs, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "localhost" = {
        root = "/var/www/html";
        locations = {
          "/" = {
            tryFiles = "$uri $uri/ /index.html";
          };
        };
      };
    };
  };

  # Create the web root directory
  system.activationScripts.createWebRoot =
    let
      webRoot = "/var/www/html";
    in
    ''
      if [ ! -d ${webRoot} ]; then
        mkdir -p ${webRoot}
        chown josp:josp ${webRoot}
        chmod 755 ${webRoot}
      fi
    '';

  # Add josp user to nginx group for file access
  users.users.josp.extraGroups = [ "nginx" ];

  # Open firewall for local access
  networking.firewall.allowedTCPPorts = [ 80 ];
}
