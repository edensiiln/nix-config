{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.lightdm.enable = true;
    windowManager.leftwm.enable = true;
    #libinput.enable = true; # Touchpad
  };
}
