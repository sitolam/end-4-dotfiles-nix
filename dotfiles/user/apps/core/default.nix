{ config, pkgs, ...}:
{
  home.packages = with pkgs; [

    # gui
    spotify
    gimp
    (discord.override {
      # withOpenASAR = true; # can do this here too
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
