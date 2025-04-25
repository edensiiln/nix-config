{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    polkitModule.enable = lib.mkEnableOption "enable polkit";
  };

  config = lib.mkIf config.polkitModule.enable {
    security.polkit = {
      enable = true;
      extraConfig= ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

    }; 
  };
}
