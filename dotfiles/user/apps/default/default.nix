{ config, pkgs, ...}:
{
  home.packages with pkgs= [
    hello-world
  ];
}
