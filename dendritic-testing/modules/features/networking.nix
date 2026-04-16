{ self, inputs, ... }: {
  
  flake.nixosModules.ssh = {pkgs, lib, ... }: {
    services.openssh.enable = true;
    programs.ssh = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostplatform.system}.edenSSH;
    }
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
