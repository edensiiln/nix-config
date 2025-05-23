# configurations for shells and shell prompts
{
  lib,
  config,
  pkgs,
  ...
}: let
  shellAliases = {
    ns = "sudo nixos-rebuild switch";
    nsf = "sudo nixos-rebuild switch --flake";
    nsd = "sudo nixos-rebuild switch --flake ~/.dotfiles";

    hs = "home-manager switch";
    hsf = "home-manager switch --flake";
    hsd = "home-manager switch --flake ~/.dotfiles";

    s = "sudo";
    ":q" = "exit";
    #cd = "z";
    #zz = "z -";

    cargo = "cargo mommy";

    yta-aac = "yt-dlp --extract-audio --audio-format aac";
    yta-best = "yt-dlp --extract-audio --audio-format best";
    yta-flac = "yt-dlp --extract-audio --audio-format flac";
    yta-mp3 = "yt-dlp --extract-audio --audio-format mp3";
    ytv-best = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4";
  };
in {

  options = {
    shModule.enable = lib.mkEnableOption "enable shells";
  };

  config = {
    programs.bash = {
      enable = true;
      inherit shellAliases;
    };
    programs.zsh = {
      enable = true;
      inherit shellAliases;
    };
    programs.nushell = {
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

    # Prompts
    programs.starship = {
      enable = true;
      settings = {
      };
    };

    # Zoxide
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      options = ["--cmd cd"];
    };
  };
}
