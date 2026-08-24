{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorscheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;

  gtk = {
    enable = true;
    theme.package = pkgs.tokyonight-gtk-theme;
    theme.name = "tokyonight-gtk-theme";

    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";

    #iconTheme.package =
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "tokyo-night";
  };

  #home-manager.lib.homeManagerConfiguration.extraSpecialArgs = {
  #    wallpaper = "pink-clouds.png";
  #  };
}
