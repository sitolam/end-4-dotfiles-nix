{ config, pkgs, inputs, ...}:
{

  imports = [
    ./spotify.nix
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
