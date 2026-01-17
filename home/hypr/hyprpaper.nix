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

        wallpaper = [
	  {
	    monitor = "";
	    path = "~/.dotfiles/backgrounds/pink-clouds.png";
	  }
	];
      };
    };
    
  };
}
