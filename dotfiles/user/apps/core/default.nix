{ config, pkgs, inputs, ...}:
{

  imports = [
    ./gparted.nix
    ./kde-connect.nix
  ];
  
  home.packages = with pkgs; [

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
    unp
    ncdu
    qpwgraph
    nwg-displays
    udiskie
    ntfs3g
  ];
}
