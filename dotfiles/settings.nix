{pkgs, ...}:

let
  secrets = import ./secrets.nix { inherit pkgs; };
in

rec {
    system = "x86_64-linux";
    hostname = "nixos"; # Hostname
    username = "otis"; # Username
    profile = "desktop"; # Select from profiles directory
    timezone = "Europe/Brussels"; # Select timezone
    locale = "en_US.UTF-8"; # Select locale
    timelocale = "nl_BE.UTF-8";
    name = "Otis"; # Name (git config)
    email = "otis.lammertyn@gmail.com"; # Email (git config)
    dotfilesDir = "/home/${username}/end-4-dotfiles-nix/dotfiles"; # Absolute path of the local repo
    theme = "nord"; # Selected theme from themes directory (./themes/)
    themeDetails = import (./. + "/themes/${theme}.nix") {dir = dotfilesDir;};
    monitors = [
        "DP-3, 1920x1080@60, 0x0, 1"
        "HDMI-A-1, 1920x1080@60, 1920x0, 1"
    ]; # Monitor preferences


    icons = "Adwaita";
    iconsPkg = pkgs.adwaita-icon-theme;
    GTK_THEME = "adw-gtk3"; # GTK theme

    # Session variables.


    # Syncthing ID
    syncthing_ID = secrets.syncthing_ID; # Set this in secrets.nix
}