{ config, pkgs, ...}:
{

  services.kdeconnect = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    settings = {
      "exec-once" = [
        "kdeconnectd"
      ];
    };
  };

}