{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ 
    starship 
    # kitty-themes
  ];
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      # character = {
      #   success_symbol = "[](bold green) ";
      #   error_symbol = "[✗](bold red) ";
      # };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      home-update = "home-manager switch --flake ~/.dotfiles";
      clean = "sudo nix-collect-garbage -d";
      home-clean = "nix-collect-garbage -d";
      clr = "clear";
      mkdir = "mkdir -p";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    # initExtra = "eval \"\$(starship init zsh)\";
    initExtra = "eval \"$(starship init zsh)\"";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      # theme = "robbyrussell";
    };

  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
    # themeFile = "Catppuccin-Mocha";
    themeFile = "tokyo_night_night";
    extraConfig = ''
    background_opacity 0.95
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    # NIXOS_OZONE_WL = "1";
  };

}
