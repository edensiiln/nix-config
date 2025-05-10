{lib, ...}: {
  imports = [
    ./hypr
    ./alacritty.nix
    ./git.nix
    ./nvf.nix

    #enabled by default
    ./sh.nix
  ];
  
  shModule.enable = lib.mkDefault true;
}
