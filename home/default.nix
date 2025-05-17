{lib, ...}: {
  imports = [
    ./hypr
    ./alacritty.nix
    ./git.nix
    ./nvf.nix

    #enabled by default
    ./yazi.nix
    ./sh.nix
  ];
  
  yaziModule.enable = lib.mkDefault true;
  shModule.enable = lib.mkDefault true;

}
