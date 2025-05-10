{ config, pkgs, ...}:
{

  imports = [

  ];

    home.packages = with pkgs; [

    flutter
    pkg-config
    

  ];
}