{ config, pkgs, ...}:
{

  imports = [

  ];

    home.packages = with pkgs; [

    gimp
    inkscape

  ];
}