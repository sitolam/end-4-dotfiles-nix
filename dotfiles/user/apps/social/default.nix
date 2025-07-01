{ config, pkgs, ...}:
{

  imports = [

  ];

  home.packages = with pkgs; [

    (discord.override {
      withVencord = true;
    })
    signal-desktop
    element-desktop
  ];

  wayland.windowManager.hyprland = {
    settings = {
      "exec-once" = [
        "discord --start-minimized"
        "signal-desktop --start-in-tray"
        "element-desktop --hidden"
      ];
    };
  };



}
