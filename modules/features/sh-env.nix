{
  self,
  inputs,
  ...
}: let
  shellAliases = {
    ns = "sudo nixos-rebuild switch";
    nsf = "sudo nixos-rebuild switch --flake";
    nsd = "sudo nixos-rebuild switch --flake ~/.dotfiles";

    hs = "home-manager switch";
    hsf = "home-manager switch --flake";
    hsd = "home-manager switch --flake ~/.dotfiles";

    ":q" = "exit";

    yta-aac = "yt-dlp --extract-audio --audio-format aac";
    yta-best = "yt-dlp --extract-audio --audio-format best";
    yta-flac = "yt-dlp --extract-audio --audio-format flac";
    yta-mp3 = "yt-dlp --extract-audio --audio-format mp3";
    ytv-best = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4";

    cargo = "cargo mommy";
  };
in {
  flake.homeModules.edenShells = {
    pkgs,
    lib,
    ...
  }: {
    programs = {

      # SHELLS
      bash = {
        enable = true;
        inherit shellAliases;
      };
      zsh = {
        enable = true;
        inherit shellAliases;
      };
      nushell = {
        enable = true;
        shellAliases =
          shellAliases
          // {
            cat = "bat";
          };
        extraConfig = ''
          $env.config = {
            show_banner: false
          }
        '';
      };

      starship = {
        enable = true;
        settings = {
        };
      };

      # CLI
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
        options = ["--cmd cd"];
      };
      fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        #enableNushellIntegration = true;
      };
      
      man.enable = true;
      btop.enable = true;
      neovim.enable = true;

    };

    home.packages = with pkgs; [
      fastfetch
      yt-dlp
      bat
      #z-lua
      fzf
      zellij
      tldr
      wget
      unzip
      libqalculate
    ];
    home.sessionVariables.EDITOR = lib.getExe pkgs.neovim;
  };
}
