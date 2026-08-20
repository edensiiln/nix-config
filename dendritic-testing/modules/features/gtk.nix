{
  flake.nixosModules.edenGtk = {
    pkgs,
    lib,
    ...
  }: let
    #theme-name = "TokyoNight";
    #theme-package = pkgs.tokyonight-gtk-theme.override {
    #  colorVariants = ["dark"];
    #  sizeVariants = ["standard"];
    #  themeVariants = ["red"];
    #  tweakVariants = ["storm"];
    #  iconVariants = ["Dark"];
    #};
    theme-name = "MagneticCatppuccin";
    theme-package = pkgs.magnetic-catppuccin-gtk;

      gtkSettings = '' 
        [Settings]
        gtk-theme-name = ${theme-name}
      '';
  in {
    environment.etc = {
      "xdg/gtk-3.0/settings.ini".text = gtkSettings;
      "xdg/gtk-4.0/settings.ini".text = gtkSettings;
    };

    environment.variables = {
      GTK_THEME = theme-name;
    };

    environment.systemPackages = [
      theme-package
      pkgs.gtk3
      pkgs.gtk4
    ];
  };
}
