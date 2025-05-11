{lib, ...}: {
  imports = [
    ./hypr
    ./alacritty.nix
    ./git.nix
    ./nvf.nix
    ./yazi.nix

    #enabled by default
    ./sh.nix
  ];
  
  #yaziModule.enable = lib.mkDefault true;
  shModule.enable = lib.mkDefault true;

  #programs.yazi.enable = true;
}
