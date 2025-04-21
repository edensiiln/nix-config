{...}: {
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-label/MEDIA";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
    ];
  };
  fileSystems."/mnt/backup-ext4" = {
    device = "/dev/disk/by-label/BACKUP-EXT4";
    fsType = "ext4";
    options = [
      "users"
      "nofail"
    ];
  };
  fileSystems."/mnt/backup-ntfs" = {
    device = "/dev/disk/by-label/BACKUP-NTFS";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
    ];
  };
}
