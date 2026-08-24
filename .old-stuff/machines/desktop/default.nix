{...}: {
  imports = [
    ./boot.nix
    ./filesystems.nix
    ./hardware-configuration.nix
    ./nvidia-drivers.nix
  ];
}
