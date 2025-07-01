{ config, pkgs, ...}:
{

  imports = [
    ./obs.nix
    ./spotify.nix
  ];

    home.packages = with pkgs; [

    gimp
    inkscape
    kdePackages.kdenlive

    # Video
    mpv
    vlc
    clapper

    handbrake

  ];
}