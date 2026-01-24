{ ... }:
{
  fileSystems = {
    "/mnt/mnemosyne-josp/" = {
      device = "//192.168.199.25/Mnemosyne/josp";
      fsType = "nfs";
      options = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    };
  };
}
