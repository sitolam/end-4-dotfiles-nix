{ config, pkgs, inputs, settings, lib, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  imports = [
    inputs.illogical-impulse.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
     (import ../../themes/stylix.nix {inherit pkgs config lib settings;})
     ./../../user/apps/core
    # ./shell.nix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/otis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # BigSaltyFishes End-4 Dotfiles Setup=================



  
  illogical-impulse = {
    # Enable Dotfiles
    enable = true;
    hyprland = {
      # Monitor preference
      monitor = settings.monitors;
      # Use cusomize hyprland packages
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      # xdgPortalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      # Set NIXOS_OZONE_WL=1
      ozoneWayland.enable = true;
    };
    theme = {
      # Customize Cursors,
      # the following config is the default config
      # if you don't set.
      cursor = {
        package = pkgs.bibata-cursors;
        theme = "Bibata-Modern-Ice";
      };
    };
    # Use custom ags package, the following package is the default.
    # agsPackage = ags.packages.${pkgs.system}.default.override {
    #   extraPackages = with pkgs; [ 
    #     gtksourceview
    #     gtksourceview4
    #     webkitgtk
    #     webp-pixbuf-loader
    #     ydotool
    #   ];
    # };
  };
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "Super, L, exec, pidof hyprlock || hyprlock" # Lock
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
      };
    };
  };
  


  # ====================================================
}
