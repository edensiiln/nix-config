{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./git.nix
    ./hyprland.nix
    ./kanshi.nix
    ./nvf.nix
    ./sh.nix
    ./waybar.nix

    #enabled by default
    ./sh.nix
  ];
  
  shModule.enable = lib.mkDefault true;
}
