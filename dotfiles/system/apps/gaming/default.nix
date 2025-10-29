{ config, pkgs, settings, ...}:
{

  imports = [
    ./gpu-screen-recorder.nix
  ];
  
  home-manager.users.${settings.username} = {
    imports = [
      ./modrinth.nix
    ];
  };


  programs.steam.enable = true; # Enable Steam
  programs.steam.gamescopeSession.enable = true; # Fix resulation upscaling in steam games

  # Proton up
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${settings.username}/.steam/root/compatibilitytools.d";
  };


  environment.systemPackages = with pkgs; [

    prismlauncher
    lutris
    heroic
    mangohud
    protonup
    protonup-qt

  ];
}