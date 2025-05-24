{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home
  ];

  # CUSTOM MODULES
  gitModule.enable = true;
  nvfModule.enable = true;

  programs.home-manager.enable = true;
  home.username = "arkserver";
  home.homeDirectory = "/home/arkserver";

  home.stateVersion = "23.11"; # don't change unless you know what you're doing

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    yt-dlp
  ];

  home.file = {};

  home.file.".config/ranger/rc.conf".source = ../../.config/ranger/rc.conf;
  home.file.".config/ranger/rifle.conf".source = ../../.config/ranger/rifle.conf;
  home.file.".config/ranger/scope.sh" = {
    source = ../../.config/ranger/scope.sh;
    executable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
