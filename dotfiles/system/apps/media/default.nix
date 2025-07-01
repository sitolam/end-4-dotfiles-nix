{ config, pkgs, ...}:
{

  imports = [
    ./droidcam.nix
    ./noisetorch.nix
  ];

  environment.systemPackages = with pkgs; [


  ];

}