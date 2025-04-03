{ config, inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorscheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
  #wallpaper = "pink-clouds.png";
}
