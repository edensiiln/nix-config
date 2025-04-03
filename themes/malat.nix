{ config, inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorscheme = inputs.nix-colors.colorSchemes.twilight;
  #wallpaper = "pink-clouds.png";
}
