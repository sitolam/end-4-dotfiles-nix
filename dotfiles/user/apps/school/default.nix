{ config, pkgs, ...}:
{

  imports = [
    ./antimicrox
  ];

    home.packages = with pkgs; [

    zotero
    anki
    onlyoffice-desktopeditors

  ];
}