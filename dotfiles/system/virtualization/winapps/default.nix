{ config, pkgs, settings, winapps, ...}:

{

  imports = [
    ./../docker.nix
    ./windows.nix
    ];

  environment.systemPackages = [
    winapps.packages."${settings.system}".winapps
    winapps.packages."${settings.system}".winapps-launcher # optional
  ];

  home-manager.users.${settings.username}.home.file."/home/${settings.username}/.config/winapps/winapps.conf".source = ./winapps.conf;

}