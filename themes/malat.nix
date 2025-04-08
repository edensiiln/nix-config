{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  #colorscheme = inputs.nix-colors.colorSchemes.twilight;
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  gtk = {
    enable = true;
    theme.package = pkgs.gruvbox-dark-gtk;
    theme.name = "gruvbox-dark-gtk";
    
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";
    
    #iconTheme.package = 
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gruvbox-dark";
  };
  
        #home-manager.lib.homeManagerConfiguration.extraSpecialArgs = {
        #    wallpaper = "golden-woods.png";
        #  };
}
