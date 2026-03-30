{ ... }:
{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems = {
    "/mnt/mnemosyne-josp" = {
      device = "//192.168.199.25:/mnt/Mnemosyne/josp";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
      ];
    };
  };
}
