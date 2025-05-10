{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./kanshi.nix
    ./waybar.nix

    #enabled by default
    #./sh.nix
  ];
  
  #shModule.enable = lib.mkDefault true;
}
