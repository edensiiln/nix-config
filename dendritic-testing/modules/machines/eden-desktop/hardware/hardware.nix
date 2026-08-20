{
  flake.nixosModules.edenTower = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];
    boot.loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
      };
    };

    fileSystems."/" = {
      #device = "/dev/disk/by-uuid/dc81cebf-01e8-48dc-9fea-02fae24de357";
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };

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

    swapDevices = [];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
