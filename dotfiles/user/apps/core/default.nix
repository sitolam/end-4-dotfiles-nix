{ config, pkgs, inputs, ...}:
{

  imports = [
    ./spotify.nix
    ./gparted.nix
    ./kde-connect.nix
  ];
  
  home.packages = with pkgs; [

    # gui
    (discord.override {
      withVencord = true;
    })

    # gnome
    gnome-clocks


    # tools
    wget
    btop
    mission-center
    bat
    eza
    zip
    unzip
    qpwgraph
    udiskie
  ];
}
