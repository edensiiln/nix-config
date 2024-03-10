{ config, pkgs, ... }:
{
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
