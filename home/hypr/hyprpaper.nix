{
  lib,
  config,
  ...
}:
{
  options = {
    hyprpaperModule.enable = lib.mkEnableOption "enable hyprpaper";
  };

  config = lib.mkIf config.hyprpaperModule.enable {
    services.hyprpaper= {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;

        preload = ["~/.dotfiles/backgrounds/pink-clouds.png"];

        wallpaper = [",~/.dotfiles/backgrounds/pink-clouds.png"];
      };
    };
    
  };
}
