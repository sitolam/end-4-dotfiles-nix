{ config, pkgs, ...}:
{

  imports = [
    ./obs.nix
  ];

    home.packages = with pkgs; [

    gimp
    inkscape
    kdePackages.kdenlive

  ];
}