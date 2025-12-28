{pkgs, ...}:

let
  secrets = import ./secrets.nix { inherit pkgs; };
in

rec {
    hostname = "nixos"; # Hostname
    username = "otis"; # Username
    timezone = "Europe/Brussels"; # Select timezone
    locale = "en_US.UTF-8"; # Select locale
    timelocale = "nl_BE.UTF-8";
    name = "Otis"; # Name (git config)
    email = "otis.lammertyn@gmail.com"; # Email (git config)
    dotfilesDir = "/home/${username}/end-4-dotfiles-nix/dotfiles"; # Absolute path of the local repo
    theme = "nord"; # Selected theme from themes directory (./themes/)
    themeDetails = import (./. + "/themes/${theme}.nix") {dir = dotfilesDir;};


    icons = "Adwaita";
    iconsPkg = pkgs.adwaita-icon-theme;
    GTK_THEME = "adw-gtk3"; # GTK theme

    # Session variables.


    # Syncthing ID
    syncthing_ID = secrets.syncthing_ID; # Set this in secrets.nix
}