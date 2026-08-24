{ self, inputs, ... }: {

  flake.nixosModules.edenNetworking = {pkgs, lib, ... }: {
    networking.networkmanager.enable = true;
  };

  flake.nixosModules.ssh = {pkgs, lib, ... }: {
    services.openssh.enable = true;
    programs.ssh = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostplatform.system}.edenSSH;
    };

    security.polkit = {
      enable = true;
      extraConfig = ''
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

  perSystem = { pkgs, lib, ... }: {

    packages.edenSSH = {
      extraConfig = "
        Host desktop
          hostname 192.168.1.56
          Port 22
          User eden
          IdentityFile ~/.ssh/desktop

        Host laptop
          hostname 192.168.1.77
          Port 22
          User eden
          IdentityFile ~/.ssh/laptop
        
        Host arkserver
          hostname 192.168.1.63
          Port 0102
          User siiln
          IdentityFile ~/.ssh/arkserver

        Host nexus
          hostname 192.168.1.63
          Port 0102
          User nexus
          Identityfile ~/.ssh/nexus
      ";
    };
  };
}
