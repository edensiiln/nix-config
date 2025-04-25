{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    fontsModule.enable = lib.mkEnableOption "enable nerdfonts";
  };

  config = lib.mkIf config.fontsModule.enable {
    fonts.packages = with pkgs; [
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
      nerd-fonts.symbols-only
      font-awesome
      powerline-fonts
      powerline-symbols
    ];
  };
}
