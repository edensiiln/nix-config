{lib, ...}: {
  imports = [
    ./remote-desktop
    ./wm
    ./bluetooth.nix
    #./minecraft-servers.nix
    ./plex.nix
    ./printing.nix
    ./sound.nix
    ./steam.nix

    #enabled by default
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./polkit.nix
  ];
  
  fontsModule.enable = lib.mkDefault true;
  localeModule.enable = lib.mkDefault true;
  networkingModule.enable = lib.mkDefault true;
  polkitModule.enable = lib.mkDefault true;
}
