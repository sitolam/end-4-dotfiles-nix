{ config, lib, pkgs, settings, ... }:


{

  imports = [
    ./kanata
  ];

  services = {
    input-remapper.enable = true;
  };
}