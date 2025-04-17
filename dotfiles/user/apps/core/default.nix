{ config, pkgs, inputs, ...}:
{

  imports = [
    ./spotify.nix
    ./gparted.nix
  ];
  
  home.packages = with pkgs; [

    # gui
    gimp
    (discord.override {
      withVencord = true;
    })


    # tools
    btop
    bat
    eza
    zip
    unzip
  ];
}
