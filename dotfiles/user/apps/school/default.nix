{ config, pkgs, ...}:
{

  imports = [

  ];

    home.packages = with pkgs; [

    zotero
    anki

  ];
}