{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    soundModule.enable = lib.mkEnableOption "enable sound";
  };

  config = lib.mkIf config.soundModule.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
