{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cifs-utils ];
  services.gvfs.enable = true;

  fileSystems = {
    "/mnt/mnemosyne" = {
      device = "//192.168.199.25/Mnemosyne";
      fsType = "cifs";
      options =
        let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in
        [ "${automount_opts},credentials=/home/josp/configs/nixos-config/smb-secrets" ];
    };
  };
}
