{ config, pkgs, ...}:
{

  imports = [
    ./droidcam.nix
  ];

  environment.systemPackages = with pkgs; [


  ];
}