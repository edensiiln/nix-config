{lib, ...}: {
  imports = [
    ./bluetooth.nix
    ./locale.nix
    ./networking.nix
    ./nvidia_drivers.nix
    ./plex.nix
    ./sound.nix
    ./steam.nix
  ];

  localeModule.enable = lib.mkDefault true;
  networkingModule.enable = lib.mkDefault true;
}
