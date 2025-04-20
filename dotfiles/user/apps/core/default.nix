{ config, pkgs, inputs, ...}:
{

  imports = [
    ./spotify.nix
    ./gparted.nix
  ];
  
  home.packages = with pkgs; [

    # gui
    (discord.override {
      withVencord = true;
    })


    # tools
    btop
    mission-center
    bat
    eza
    zip
    unzip
  ];
}
