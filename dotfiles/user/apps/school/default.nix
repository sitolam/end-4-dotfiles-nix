{ config, pkgs, ...}:
{

  imports = [
    ./antimicrox
  ];

    home.packages = with pkgs; [

    zotero
    anki-bin
    onlyoffice-desktopeditors

  ];
}